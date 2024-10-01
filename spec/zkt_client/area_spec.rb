# frozen_string_literal: true

RSpec.describe ZktClient::Area do
  context "when json respons" do
    it "returns area hash" do
      VCR.use_cassette("area_show_hash") do
        area = described_class.show(1)

        expect(area).to(be_a(Hash))
      end
    end

    it "returns array of hashes" do
      VCR.use_cassette("areas_list_hashes") do
        areas = described_class.list

        expect(areas["data"]).to(be_a(Array))
        expect(areas.keys).to(include("count", "next", "previous"))
        expect(areas["data"].first).to(be_a(Hash))
      end
    end

    it "creates a new area and returns hash" do
      VCR.use_cassette("create_area_and_return_hash") do
        area = described_class.create(area_code: 10_000, area_name: "Ahmed S Baqtyan")

        expect(area).to(be_a(Hash))
        expect(area["area_code"]).to(eq("10000"))
        expect(area["area_name"]).to(eq("Ahmed S Baqtyan"))
      end
    end

    it "updates a specific area and returns hash" do
      VCR.use_cassette("update_area_and_return_hash") do
        updateable_area = described_class.list["data"].first
        updated_area = described_class.update(updateable_area["id"], area_name: "Ahmed S O Baqtyan")

        expect(updated_area).to(be_a(Hash))
        expect(updateable_area["area_name"]).to_not(eq(updated_area["area_name"]))
      end
    end

    it "deletes a specific area and returns true" do
      VCR.use_cassette("delete_area_and_return_true") do
        deleteable_area_id = described_class.list["data"].first["id"]

        expect(described_class.delete(deleteable_area_id)).to(be_truthy)
      end
    end
  end

  context "when object response" do
    before { ZktClient.is_object_response_enabled = true }

    it "returns area object" do
      VCR.use_cassette("area_show_object") do
        area = described_class.show(1)

        expect(area).to(be_a(OpenStruct))
      end
    end

    it "returns arrays of objects" do
      VCR.use_cassette("areas_list_objects") do
        areas = described_class.list

        expect(areas).to(be_a(Array))
        expect(areas.first).to(be_a(OpenStruct))
      end
    end

    it "creates a new area and returns object" do
      VCR.use_cassette("create_area_and_return_object") do
        area = described_class.create(area_code: 10_001, area_name: "Ahmed S O Baqtyan")

        expect(area).to(be_a(OpenStruct))
        expect(area.area_code).to(eq("10001"))
        expect(area.area_name).to(eq("Ahmed S O Baqtyan"))
      end
    end

    it "updates a specific area and returns hash" do
      VCR.use_cassette("update_area_and_return_object") do
        updateable_area = described_class.list.first
        updated_area = described_class.update(updateable_area.id, area_name: "Salem A O Baqtyan")

        expect(updated_area).to(be_a(OpenStruct))
        expect(updateable_area.area_name).to_not(eq(updated_area.area_name))
      end
    end
  end
end
