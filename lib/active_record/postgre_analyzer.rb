require "active_record"
require "active_record/log_subscriber"

require "active_record/postgre_analyzer/version"

module ActiveRecord
  module PostgreAnalyzer
    class LogSubscriber < ActiveRecord::LogSubscriber
      IGNORED_PAYLOADS = %w(SCHEMA EXPLAIN CACHE)
      EXPLAINED_SQLS = /\A\s*(select|update|delete|insert)\b/i
      SEQ_SCAN = /.*Seq Scan.*/

      def sql(event)
        payload = event.payload

        return if ignore_payload?(payload)

        # disable SeqScan when index exists
        ActiveRecord::Base.connection.execute("SET enable_seqscan TO off", "SCHEMA")

        explain_result = ActiveRecord::Base.connection.explain(payload[:sql], payload[:binds])
        if seq_scan?(explain_result)
          debug '------------ find Seq Scan query ------------'
          debug payload[:sql]
          debug explain_result
        end
      end

      def ignore_payload?(payload)
        payload[:exception] || IGNORED_PAYLOADS.include?(payload[:name]) || payload[:sql] !~ EXPLAINED_SQLS
      end

      def seq_scan?(explain_result)
        explain_result =~ SEQ_SCAN
      end
    end
  end
end

ActiveSupport.on_load(:active_record) do
  ActiveRecord::PostgreAnalyzer::LogSubscriber.attach_to :active_record
end
