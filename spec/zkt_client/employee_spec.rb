# frozen_string_literal: true

RSpec.describe ZktClient::Employee do
  context 'when json respons' do
    it "returns employee hash" do
      VCR.use_cassette('employee_show_hash') do
        employee = described_class.show(62)

        expect(employee).to(be_a(Hash))
      end
    end

    it "returns array of hashes" do
      VCR.use_cassette('employees_list_hashes') do
        employees = described_class.list

        expect(employees['data']).to(be_a(Array))
        expect(employees.keys).to(include('count', 'next', 'previous'))
        expect(employees['data'].first).to(be_a(Hash))
      end
    end

    it "creates a new employee and returns hash" do
      VCR.use_cassette('create_employee_and_return_hash') do
        employee = described_class.create(emp_code: 10001, first_name: 'Ahmed S Baqtyan', department: 1, area: [1])

        expect(employee).to(be_a(Hash))
        expect(employee['emp_code']).to(eq("10001"))
        expect(employee['first_name']).to(eq("Ahmed S Baqtyan"))
        expect(employee['department']).to(eq(1))
        expect(employee['area']).to(eq([1]))
      end
    end

    it "updates a specific employee and returns hash" do
      VCR.use_cassette('update_employee_and_return_hash') do
        updateable_employee = described_class.list['data'].first
        updated_employee = described_class.update(updateable_employee['id'], area: [1], first_name: 'Salim A Baqtyan')

        expect(updated_employee).to(be_a(Hash))
        expect(updateable_employee['area']).to_not(eq(updated_employee['area']))
        expect(updateable_employee['first_name']).to_not(eq(updated_employee['first_name']))
      end
    end

    it "deletes a specific employee and returns true" do
      VCR.use_cassette('delete_employee_and_return_true') do
        deleteable_employee_id = described_class.list['data'].first['id']

        expect(described_class.delete(deleteable_employee_id)).to(be_truthy)
      end
    end
  end

  context 'when object response' do
    before { ZktClient.is_object_response_enabled = true }

    it "returns employee object" do
      VCR.use_cassette('employee_show_object') do
        employee = described_class.show(62)

        expect(employee).to(be_a(OpenStruct))
      end
    end

    it "returns arrays of objects" do
      VCR.use_cassette('employees_list_objects') do
        employees = described_class.list

        expect(employees).to(be_a(Array))
        expect(employees.first).to(be_a(OpenStruct))
      end
    end

    it "creates a new employee and returns object" do
      VCR.use_cassette('create_employee_and_return_object') do
        employee = described_class.create(emp_code: 10002, first_name: 'Ahmed S O Baqtyan', department: 1, area: [1])

        expect(employee).to(be_a(OpenStruct))
        expect(employee.emp_code).to(eq("10002"))
        expect(employee.first_name).to(eq("Ahmed S O Baqtyan"))
        expect(employee.department).to(eq(1))
        expect(employee.area).to(eq([1]))
      end
    end

    it "updates a specific employee and returns hash" do
      VCR.use_cassette('update_employee_and_return_object') do
        updateable_employee = described_class.list.first
        updated_employee = described_class.update(updateable_employee['id'], area: [1], first_name: 'Salim A Baqtyan')

        expect(updated_employee).to(be_a(OpenStruct))
        expect(updateable_employee.area).to_not(eq(updated_employee.area))
        expect(updateable_employee.first_name).to_not(eq(updated_employee.first_name))
      end
    end
  end
end
