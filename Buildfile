repositories.remote << 'http://repo1.maven.org/maven2' << 'http://nexus.gephi.org/nexus/content/repositories/public'

JAVAHELP = artifact('javax.help:javahelp:jar:2.0.05')
MRJADAPTER = download artifact('net.roydesign:mrjadapter:jar:1.1') => 'http://www.docjar.com/jar/MRJAdapter.jar'
COLORPICKER = download artifact('com.bric:colorpicker:jar:1.0') => 'http://javagraphics.java.net/jars/ColorPicker.jar'
FONTCHOOSER = artifact('com.connectina.swing:fontchooser:jar:1.0')
BATIK = transitive artifact('org.apache.xmlgraphics:batik-svggen:jar:1.7')

define 'logisim' do
  project.version = '2.7.2'
  compile.using :lint=>'all'
  compile.with JAVAHELP, MRJADAPTER, COLORPICKER, FONTCHOOSER, BATIK
  compile {
    puts "Including dependencies into generated jar..."
    compile.dependencies.map do |dep|
      unzip( 'target/classes' => dep.to_s ).exclude('META-INF/*').extract
    end
  }
  manifest['Main-Class'] = 'com.cburch.logisim.Main'
  package(:jar)
end