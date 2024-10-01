# frozen_string_literal: true

RSpec.describe ZktClient::Transaction do
  context "when json respons" do
    it "returns transaction hash" do
      VCR.use_cassette("transaction_show_hash") do
        transaction = described_class.show(1)

        expect(transaction).to(be_a(Hash))
      end
    end

    it "returns array of hashes" do
      VCR.use_cassette("transactions_list_hashes") do
        transactions = described_class.list

        expect(transactions["data"]).to(be_a(Array))
        expect(transactions.keys).to(include("count", "next", "previous"))
        expect(transactions["data"].first).to(be_a(Hash))
      end
    end

    it "deletes a specific transaction and returns true" do
      VCR.use_cassette("delete_transaction_and_return_true") do
        deleteable_transaction_id = described_class.list["data"].first["id"]

        expect(described_class.delete(deleteable_transaction_id)).to(be_truthy)
      end
    end
  end

  context "when object response" do
    before { ZktClient.is_object_response_enabled = true }

    it "returns transaction object" do
      VCR.use_cassette("transaction_show_object") do
        transaction = described_class.show(2)

        expect(transaction).to(be_a(OpenStruct))
      end
    end

    it "returns arrays of objects" do
      VCR.use_cassette("transactions_list_objects") do
        transactions = described_class.list

        expect(transactions).to(be_a(Array))
        expect(transactions.first).to(be_a(OpenStruct))
      end
    end
  end
end
