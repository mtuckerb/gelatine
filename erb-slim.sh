#gem install haml hpricot ruby_parser slim haml2slim html2haml
for i in `find app/views/ -name '*.erb'` ; do html2haml -e $i ${i%erb}haml; done
for i in `find app/views/ -name '*.haml'` ; do haml2slim $i ${i%haml}slim; done
#rm -Rf erb2slim