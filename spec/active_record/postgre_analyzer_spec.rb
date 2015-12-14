RSpec.describe ActiveRecord::PostgreAnalyzer do
  let(:stringio) { StringIO.new }
  let(:logger) { Logger.new(stringio) }
  before do
    ActiveRecord::Base.logger = logger
  end

  context 'column not indexed' do
    it 'logging explain' do
      User.where(name: 'hoge').to_a
      output = stringio.tap(&:rewind).read
      expect(output).to match(/QUERY PLAN/)
      expect(output).to match(/Seq Scan on users/)
      expect(output).to match(/find Seq Scan query/)
    end
  end

  context 'column indexed' do
    it 'not logging explain' do
      User.where(name_indexed: 'hoge').to_a
      output = stringio.tap(&:rewind).read
      expect(output).not_to match(/QUERY PLAN/)
      expect(output).not_to match(/Seq Scan on users/)
      expect(output).not_to match(/find Seq Scan query/)
    end
  end

  context 'ignored query' do
    it 'not logging when execute explain' do
      ActiveRecord::Base.connection.execute("select 3", "SCHEMA")
      output = stringio.tap(&:rewind).read
      expect(output).not_to match(/QUERY PLAN/)
      expect(output).not_to match(/Seq Scan on users/)
      expect(output).not_to match(/find Seq Scan query/)
    end
  end
end
