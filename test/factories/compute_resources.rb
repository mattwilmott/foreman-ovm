FactoryGirl.define do
  factory :container_resource, :class => ComputeResource do
    sequence(:name) { |n| "compute_resource#{n}" }

    trait :ovm do
      provider 'Ovm'
      username 'test'
      password 'test'
      region 'everywhere'
    end

    factory :ovm_cr, :class => ForemanOvm::Ovm, :traits => [:ovm]
  end
end
