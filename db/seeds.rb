requestors = %w(株式会社A 株式会社B C株式会社 山田太郎 日本花子 株式会社D)
6.times do |n|
  Requestor.create!(name: requestors[n])
end