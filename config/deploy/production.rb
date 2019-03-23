# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:
server '18.222.81.124', user: 'ubuntu', roles: %w[web app db]
