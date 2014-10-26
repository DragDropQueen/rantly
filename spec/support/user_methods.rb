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

def full_name(person)
  [person.first_name, person.last_name].join(" ")
end