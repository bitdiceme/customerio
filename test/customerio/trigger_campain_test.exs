defmodule Customerio.TriggerCampaignTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "Customerio::trigger_campaign" do
    test "Successful campaign trigger" do
      use_cassette "trigger_campaign/pass" do
        assert {:ok, result} = Customerio.trigger_campaign(7, %{data: %{title: "Campaign Test"}})
        assert "{\"id\":47}" == result
      end
    end

    test "Unsuccesful campaign trigger" do
      use_cassette "trigger_campaign/fail" do
        {:error, %Customerio.Error{code: code, reason: reason}} =
          Customerio.trigger_campaign(8, %{data: %{title: "Campaign Test"}})
        assert reason =~ ~r/not found/
        assert 404 = code
      end
    end
  end
end
