# frozen_string_literal: true

RSpec.describe ZktClient::Device do
  context 'when json respons' do
    it "returns device hash" do
      VCR.use_cassette('device_show_hash') do
        device = described_class.show(40)

        expect(device).to(be_a(Hash))
      end
    end

    it "returns array of hashes" do
      VCR.use_cassette('devices_list_hashes') do
        devices = described_class.list

        expect(devices['data']).to(be_a(Array))
        expect(devices.keys).to(include('count', 'next', 'previous'))
        expect(devices['data'].first).to(be_a(Hash))
      end
    end

    xit "creates a new device and returns hash" do
      VCR.use_cassette('create_device_and_return_hash') do
        device = described_class.create(sn: 111111112, alias: 'Baqtyan Device', ip_address: '127.1.1.1')

        expect(device).to(be_a(Hash))
        expect(device['device_code']).to(eq("10000"))
        expect(device['device_name']).to(eq("Ahmed S Baqtyan"))
      end
    end

    it "updates a specific device and returns hash" do
      VCR.use_cassette('update_device_and_return_hash') do
        updateable_device = described_class.list['data'].first
        updated_device = described_class.update(updateable_device['id'], sn: '11111111223', alias: "Baqtyan's device")

        expect(updated_device).to(be_a(Hash))
        expect(updateable_device['alias']).to_not(eq(updated_device['alias']))
      end
    end

    it "deletes a specific device and returns true" do
      VCR.use_cassette('delete_device_and_return_true') do
        deleteable_device_id = described_class.list['data'].first['id']

        expect(described_class.delete(deleteable_device_id)).to(be_truthy)
      end
    end
  end

  context 'when object response' do
    before { ZktClient.is_object_response_enabled = true }

    it "returns device object" do
      VCR.use_cassette('device_show_object') do
        device = described_class.show(42)

        expect(device).to(be_a(OpenStruct))
      end
    end

    it "returns arrays of objects" do
      VCR.use_cassette('devices_list_objects') do
        devices = described_class.list

        expect(devices).to(be_a(Array))
        expect(devices.first).to(be_a(OpenStruct))
      end
    end

    xit "creates a new device and returns object" do
      VCR.use_cassette('create_device_and_return_object') do
        device = described_class.create(device_code: 10001, device_name: 'Ahmed S O Baqtyan')

        expect(device).to(be_a(OpenStruct))
        expect(device.device_code).to(eq("10001"))
        expect(device.device_name).to(eq("Ahmed S O Baqtyan"))
      end
    end

    it "updates a specific device and returns hash" do
      VCR.use_cassette('update_device_and_return_object') do
        updateable_device = described_class.list.first
        updated_device = described_class.update(updateable_device['id'], sn: '11111111223', alias: "Baqtyan's device")

        expect(updated_device).to(be_a(OpenStruct))
        expect(updateable_device.alias).to_not(eq(updated_device.alias))
      end
    end
  end
end
