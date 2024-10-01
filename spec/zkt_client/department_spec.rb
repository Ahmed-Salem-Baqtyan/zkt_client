# frozen_string_literal: true

RSpec.describe ZktClient::Department do
  context "when json respons" do
    it "returns department hash" do
      VCR.use_cassette("department_show_hash") do
        department = described_class.show(1)

        expect(department).to(be_a(Hash))
      end
    end

    it "returns array of hashes" do
      VCR.use_cassette("departments_list_hashes") do
        departments = described_class.list

        expect(departments["data"]).to(be_a(Array))
        expect(departments.keys).to(include("count", "next", "previous"))
        expect(departments["data"].first).to(be_a(Hash))
      end
    end

    it "creates a new department and returns hash" do
      VCR.use_cassette("create_department_and_return_hash") do
        department = described_class.create(dept_code: 10_000, dept_name: "Ahmed S Baqtyan")

        expect(department).to(be_a(Hash))
        expect(department["dept_code"]).to(eq("10000"))
        expect(department["dept_name"]).to(eq("Ahmed S Baqtyan"))
      end
    end

    it "updates a specific department and returns hash" do
      VCR.use_cassette("update_department_and_return_hash") do
        updateable_department = described_class.list["data"].first
        updated_department = described_class.update(updateable_department["id"], dept_name: "Ahmed S O Baqtyan")

        expect(updated_department).to(be_a(Hash))
        expect(updateable_department["dept_name"]).to_not(eq(updated_department["dept_name"]))
      end
    end

    it "deletes a specific department and returns true" do
      VCR.use_cassette("delete_department_and_return_true") do
        deleteable_department_id = described_class.list["data"].first["id"]

        expect(described_class.delete(deleteable_department_id)).to(be_truthy)
      end
    end
  end

  context "when object response" do
    before { ZktClient.is_object_response_enabled = true }

    it "returns department object" do
      VCR.use_cassette("department_show_object") do
        department = described_class.show(1)

        expect(department).to(be_a(OpenStruct))
      end
    end

    it "returns arrays of objects" do
      VCR.use_cassette("departments_list_objects") do
        departments = described_class.list

        expect(departments).to(be_a(Array))
        expect(departments.first).to(be_a(OpenStruct))
      end
    end

    it "creates a new department and returns object" do
      VCR.use_cassette("create_department_and_return_object") do
        department = described_class.create(dept_code: 10_001, dept_name: "Ahmed S O Baqtyan")

        expect(department).to(be_a(OpenStruct))
        expect(department.dept_code).to(eq("10001"))
        expect(department.dept_name).to(eq("Ahmed S O Baqtyan"))
      end
    end

    it "updates a specific department and returns hash" do
      VCR.use_cassette("update_department_and_return_object") do
        updateable_department = described_class.list.first
        updated_department = described_class.update(updateable_department.id, dept_name: "Salem A O Baqtyan")

        expect(updated_department).to(be_a(OpenStruct))
        expect(updateable_department.dept_name).to_not(eq(updated_department.dept_name))
      end
    end
  end
end
