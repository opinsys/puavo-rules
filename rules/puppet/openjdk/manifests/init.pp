class openjdk {
  include packages

  $version = 8

  define jdk_alternative ($subdir) {
    $cmdname = $title
    $targetpath = "/usr/lib/jvm/java-${openjdk::version}-openjdk-i386/${subdir}/${cmdname}"

    exec {
      "set alternative $cmdname to $targetpath":
        command => "/usr/bin/update-alternatives --set ${cmdname} ${targetpath}",
        require => Package['openjdk-8-jdk'],
        unless  => "/usr/bin/update-alternatives --query ${cmdname} | /bin/grep -qx 'Value: ${targetpath}'";
    }
  }

  jdk_alternative {
    [ 'appletviewer'
    , 'extcheck'
    , 'idlj'
    , 'jar'
    , 'jarsigner'
    , 'javac'
    , 'javadoc'
    , 'javah'
    , 'javap'
    , 'jcmd'
    , 'jconsole'
    , 'jdb'
    , 'jhat'
    , 'jinfo'
    , 'jmap'
    , 'jps'
    , 'jrunscript'
    , 'jsadebugd'
    , 'jstack'
    , 'jstat'
    , 'jstatd'
    , 'native2ascii'
    , 'rmic'
    , 'schemagen'
    , 'serialver'
    , 'wsgen'
    , 'wsimport'
    , 'xjc' ]:
      subdir => 'bin';

    [ 'java'
    , 'keytool'
    , 'orbd'
    , 'pack200'
    , 'policytool'
    , 'rmid'
    , 'rmiregistry'
    , 'servertool'
    , 'tnameserv'
    , 'unpack200' ]:
      subdir => 'jre/bin';

    'jexec':
      subdir => 'jre/lib';
  }


  Package <| title == openjdk-8-jdk |>
}
