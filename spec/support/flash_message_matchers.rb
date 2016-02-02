module Capybara
  class Session
    def has_flash?(kind, msg)
      within ".alert-#{kind}" do
        has_content?(msg)
      end
    end
  end
end
