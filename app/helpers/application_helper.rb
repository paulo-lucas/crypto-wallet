module ApplicationHelper
  def date_br (date_obj)
    date_obj.strftime("%d/%m/%Y")
  end

  def app_name
    "Crypto Wallet"
  end
end
