require "test_helper"

class ClientsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get clients_index_url
    assert_response :success
  end

  test "should get show" do
    client = clients(:de)

    get clients_show_url(id: client.id)
    assert_response :success
  end
end
