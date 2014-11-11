require 'rails_helper'

feature "Tasks" do

  scenario "User creates a task" do

    visit "/tasks"
    click_on "Create Task"
    fill_in "Description", with: "My awesome task"
    fill_in "Due date", with: "07/07/2015"
    click_on "Create Task"

    expect(page).to have_content("Task was successfully created")
    expect(page).to have_content("My awesome task")

  end

  scenario "User attempts to create a task with no description" do

    visit "/tasks"
    click_on "Create Task"
    click_on "Create Task"

    expect(page).to have_content("Description can't be blank")

  end

  scenario "User sees show page" do

    Task.create!(
      description: "bowling" , complete: "false" , due_date: "11/05/2014"
    )

    visit "/tasks"
    click_on "Show"
    expect(page).to have_content("bowling")

  end

  scenario "User edits a task" do

    Task.create!(
      description: "bowling" , complete: "false" , due_date: "11/05/2014"
    )

    visit "/tasks"
    click_on "Edit"
    check "Complete"
    click_on "Update Task"

    expect(page).to have_content("Task was successfully updated")
    expect(page).to have_content("bowling")

  end

  scenario "User deletes a task" do

    Task.create!(
      description: "bowling" , complete: "false" , due_date: "11/05/2014"
    )

    visit "/tasks"
    click_on "Delete"
    expect(page).to have_content("Task was successfully destroyed")
    expect(page).to have_no_content("bowling")

  end

end
