class WebhooksController < ApplicationController
  skip_before_action :authenticate
  skip_before_action :verify_authenticity_token
  
  def complete
    # if request method HEAD, else recieve payload and do stuff with it/send slack messages
    return head :ok
  end

  def receive
    binding.pry
    TrelloPayloadHandler.run(payload_params)
    
    # if only Board (i.e. NOT list and NOT card)
      # create board, associate to org, add webhook
    # if board + list and NOT card
      # create list, associate to board, add webhook
    # if board + list + card
      # create card, assocaite to list and board, add webhook
    # what payloads to we get when cards get updated -- members added/subtracted, status or lable changes, open/closed. etc.?

  end

  private

    def payload_params
      binding.pry
      params.require(:model).permit(:id)
    end

end


# {"model"=>
#   {"id"=>"578251f059bce751763c9175",
#    "name"=>"secondtestteam",
#    "displayName"=>"Second Test Team",
#    "desc"=>"another test team b/c webhooks suck",
#    "descData"=>nil,
#    "url"=>"https://trello.com/secondtestteam",
#    "website"=>nil,
#    "logoHash"=>nil,
#    "products"=>[],
#    "powerUps"=>[]},
#  "event"=>
#   {"id"=>"5782c8d38f40552d7f482815",
#    "idMemberCreator"=>"556478763b736269c0299f54",
#    "data"=>
#     {"organization"=>
#       {"name"=>"Second Test Team", "id"=>"578251f059bce751763c9175"},
#      "board"=>
#       {"shortLink"=>"eKwu4f29",
#        "name"=>"my best board ever",
#        "id"=>"5782c8d38f40552d7f482812"}},
#    "type"=>"addToOrganizationBoard",
#    "date"=>"2016-07-10T22:14:43.274Z",
#    "memberCreator"=>
#     {"id"=>"556478763b736269c0299f54",
#      "avatarHash"=>nil,
#      "fullName"=>"Sophie DeBenedetto",
#      "initials"=>"SD",
#      "username"=>"sophiedebenedetto1"}},
#  "controller"=>"webhooks",
#  "action"=>"receive",
#  "webhook"=>{}}