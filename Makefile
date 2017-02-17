all:

clean:

install:
	mkdir -p $(DESTDIR)/usr/share/backgrounds
	mkdir -p $(DESTDIR)/usr/share/gnome-background-properties
	mkdir -p $(DESTDIR)/usr/share/mate-background-properties
	
	cp -r backgrounds/* $(DESTDIR)/usr/share/backgrounds/
	cp parrot-wallpapers.xml $(DESTDIR)/usr/share/gnome-background-properties/parrot-wallpapers.xml
	cp parrot-wallpapers.xml $(DESTDIR)/usr/share/mate-background-properties/parrot-wallpapers.xml
	
	chown root:root -R $(DESTDIR)/usr/share/backgrounds
	chown root:root -R $(DESTDIR)/usr/share/gnome-background-properties/
	chown root:root -R $(DESTDIR)/usr/share/mate-background-properties/
	
	chmod 644 -R $(DESTDIR)/usr/share/backgrounds
	chmod 644 -R $(DESTDIR)/usr/share/gnome-background-properties/
	chmod 644 -R $(DESTDIR)/usr/share/mate-background-properties/
