Feature: Landing Page

As a customer,
I want to see the rcumber landing page
So I can begin to manage my customer test suite.

Scenario: Visit the rcumber landing page

	Given a cucumber test landing_page exists
	When I visit the rcumber landing page
	Then I should see "Landing Page"
	