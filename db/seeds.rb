requestors = %w(株式会社A 株式会社B C株式会社 山田太郎 日本花子 株式会社D)
6.times do |n|
  Requestor.create!(name: requestors[n])
end

2.times do |n|
  User.create!(email: "test0#{(n + 1).to_s}@example.com", password: "password", password_confirmation: "password", role: 5)
end

8.times do |n|
  User.create!(email: "test0#{(n + 3).to_s}@example.com", password: "password", password_confirmation: "password", role: 0)
end