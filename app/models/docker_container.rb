class DockerContainer
  def initialize(command, user, volume, mount_point)
    @command = command
    @user = user
    @volume = volume
    @mount_point = mount_point
  end


  def command
    "docker run #{flags} lintci/spin_cycle #{command}"
  end

  def flags
    Shellwords.join([
      "--volume=#{}",
      "--workdir=#{}",
      "--user=#{}"
    ])
  end
end
