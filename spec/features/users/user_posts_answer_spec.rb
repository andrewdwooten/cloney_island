require "rails_helper"

feature "user answers question" do
  attr_reader :user, :question
  before(:each) do
    @user = Fabricate(:user, password: 'password')
    @user.roles.create(name: 'registered_user')
    @question = Fabricate(:question, user: user)
  end
  scenario "they fill out the form on the question show page" do

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)


    visit question_path(question)

    fill_in "Enter text", with: "Dumb question"
    click_button("Submit")

    expect(current_path).to eq(question_path(question))
    within(".question-answers") do
      expect(page).to have_content("Dumb question")
    end
  end

  scenario "they fill out the form incorrectly on the question show page" do

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)


    visit question_path(question)

    within("#answer-question") do
      click_button("Submit")
    end

    expect(current_path).to eq(answers_path)

    expect(page).to have_content("Your comment was not successful.")
    within(".error") do
      expect(page).to have_content("Body can't be blank")
    end
  end
end
