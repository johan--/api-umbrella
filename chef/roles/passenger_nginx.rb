name "passenger_nginx"
description "A default role for passenger through nginx."

run_list([
  "recipe[nginx::source]",
])

default_attributes({
  :nginx => {
    :source => {
      :modules => [
        "passenger",
      ],
    },

    :passenger => {
      :version => "4.0.10",

      # Run all passengers processes as the nginx user.
      :user_switching => false,
      :default_user => "www-data-local",

      # Disable friendly error pages by default.
      :friendly_error_pages => false,

      # Allow more application instances.
      :max_pool_size => 16,

      # Ensure this is less than :max_pool_size, so there's always room for all
      # other apps, even if one app is popular.
      :max_instances_per_app => 6,

      # Keep at least one instance running for all apps.
      :min_instances => 1,

      # Increase an instance idle time to 15 minutes.
      :pool_idle_time => 900,

      # Keep the spanwers alive indefinitely, so new app processes can spin up
      # quickly.
      :max_preloader_idle_time => 0,
    },
  },
})
