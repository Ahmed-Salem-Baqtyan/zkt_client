# frozen_string_literal: true

RSpec.describe ZktClient::Position do
  context "when json respons" do
    it "returns position hash" do
      VCR.use_cassette("position_show_hash") do
        position = described_class.show(1)

        expect(position).to(be_a(Hash))
      end
    end

    it "returns array of hashes" do
      VCR.use_cassette("positions_list_hashes") do
        positions = described_class.list

        expect(positions["data"]).to(be_a(Array))
        expect(positions.keys).to(include("count", "next", "previous"))
        expect(positions["data"].first).to(be_a(Hash))
      end
    end

    it "creates a new position and returns hash" do
      VCR.use_cassette("create_position_and_return_hash") do
        position = described_class.create(position_code: 10_000, position_name: "Ahmed S Baqtyan")

        expect(position).to(be_a(Hash))
        expect(position["position_code"]).to(eq("10000"))
        expect(position["position_name"]).to(eq("Ahmed S Baqtyan"))
      end
    end

    it "updates a specific position and returns hash" do
      VCR.use_cassette("update_position_and_return_hash") do
        updateable_position = described_class.list["data"].first
        updated_position = described_class.update(updateable_position["id"], position_code: 11_111,
                                                                             position_name: "Ahmed S O Baqtyan")

        expect(updated_position).to(be_a(Hash))
        expect(updateable_position["position_name"]).to_not(eq(updated_position["position_name"]))
      end
    end

    it "deletes a specific position and returns true" do
      VCR.use_cassette("delete_position_and_return_true") do
        deleteable_position_id = described_class.list["data"].first["id"]

        expect(described_class.delete(deleteable_position_id)).to(be_truthy)
      end
    end
  end

  context "when object response" do
    before { ZktClient.is_object_response_enabled = true }

    it "returns position object" do
      VCR.use_cassette("position_show_object") do
        position = described_class.show(1)

        expect(position).to(be_a(OpenStruct))
      end
    end

    it "returns arrays of objects" do
      VCR.use_cassette("positions_list_objects") do
        positions = described_class.list

        expect(positions).to(be_a(Array))
        expect(positions.first).to(be_a(OpenStruct))
      end
    end

    it "creates a new position and returns object" do
      VCR.use_cassette("create_position_and_return_object") do
        position = described_class.create(position_code: 10_001, position_name: "Ahmed S O Baqtyan")

        expect(position).to(be_a(OpenStruct))
        expect(position.position_code).to(eq("10001"))
        expect(position.position_name).to(eq("Ahmed S O Baqtyan"))
      end
    end

    it "updates a specific position and returns hash" do
      VCR.use_cassette("update_position_and_return_object") do
        updateable_position = described_class.list.first
        updated_position = described_class.update(updateable_position.id, position_code: 1_112_121,
                                                                          position_name: "Salem A O Baqtyan")

        expect(updated_position).to(be_a(OpenStruct))
        expect(updateable_position.position_name).to_not(eq(updated_position.position_name))
      end
    end
  end
end
