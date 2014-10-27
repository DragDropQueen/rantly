def create_user(overrides = {})
  User.create!({
                 email: 'monochrome@something.com',
                 password: 'schnee337',
                 first_name: 'Blake',
                 last_name: 'Belladona',
                 bio: 'former member of the White Fang',
                 frequency: 'Daily',
                 active: true
               }.merge(overrides))
end

def create_other_user(overrides = {})
  User.create!({
                 email: 'kaine@something.com',
                 password: 'nier1337',
                 first_name: 'gestalt',
                 last_name: 'replicant',
                 bio: 'part shade',
                 frequency: 'Daily',
                 active: true
               }.merge(overrides))
end

def create_admin_user(overrides = {})
  User.create!({
    email: 'angel@feathers.com',
    password: 'judgment',
    first_name: 'Colette',
    last_name: 'Brunel',
    bio: 'the chosen one',
    frequency: 'Daily',
    active: true,
    admin: true
               })
end

def full_name(person)
  [person.first_name, person.last_name].join(" ")
end