FactoryGirl.define do
  factory :user do
    name "Douglas Adams"
    sequence(:email, 100) { |n| "person#{n}@example.com" }
    password "helloworld"
    password_confirmation "helloworld"
    confirmed_at Time.now

    factory :user_with_post_and_comment do
      transient do
        comment_count 1
      end

      after(:create) do |user, evaluator|
        post = create(:post, user: user)
        create_list(:comment, evaluator.comment_count, post: post, user: user)
        #comment = create(:comment, user: user, post: post)
        # evaluator.comment_count.times do
        #   comment = create(:comment, user: user, post: post)

        # end
      end
    end
  end
end