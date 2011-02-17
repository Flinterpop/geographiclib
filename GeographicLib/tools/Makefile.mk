# $Id$

PROGRAMS = GeoConvert TransverseMercatorTest CartConvert Geod EquidistantTest \
	GeoidEval Planimeter

all: $(PROGRAMS)

LIBSTEM = Geographic
LIBRARY = lib$(LIBSTEM).a

INCLUDEPATH = ../include
LIBPATH = ../src

# After installation, use these values of INCLUDEPATH and LIBPATH
# INCLUDEPATH = $(PREFIX)/include
# LIBPATH = $(PREFIX)/lib

CC = g++ -g
CXXFLAGS = -g -Wall -O3 -funroll-loops -finline-functions -fomit-frame-pointer

CPPFLAGS = -I$(INCLUDEPATH) $(DEFINES)
LDLIBS = -L$(LIBPATH) -l$(LIBSTEM)


$(PROGRAMS): $(LIBPATH)/$(LIBRARY)
	$(CC) -o $@ $@.o $(LDLIBS)

VPATH = ../include/GeographicLib

clean:
	rm -f *.o

GeoConvert: GeoConvert.o
TransverseMercatorTest: TransverseMercatorTest.o
CartConvert: CartConvert.o
Geod: Geod.o
EquidistantTest: EquidistantTest.o
GeoidEval: GeoidEval.o
Planimeter: Planimeter.o

%.usage: %.pod
	sh makeusage.sh $< > $@

GeoConvert.o: GeoConvert.usage Constants.hpp DMS.hpp GeoCoords.hpp \
	UTMUPS.hpp
TransverseMercatorTest.o: TransverseMercatorTest.usage Constants.hpp \
	DMS.hpp EllipticFunction.hpp TransverseMercator.hpp \
	TransverseMercatorExact.hpp
CartConvert.o: CartConvert.usage Constants.hpp DMS.hpp Geocentric.hpp \
	LocalCartesian.hpp
Geod.o: Geod.usage Constants.hpp DMS.hpp Geodesic.hpp GeodesicLine.hpp
EquidistantTest.o: EquidistantTest.usage AzimuthalEquidistant.hpp \
	CassiniSoldner.hpp Gnomonic.hpp Constants.hpp DMS.hpp Geodesic.hpp \
	GeodesicLine.hpp
GeoidEval.o: GeoidEval.usage Constants.hpp DMS.hpp GeoCoords.hpp Geoid.hpp
Planimeter.o: Planimeter.usage Constants.hpp DMS.hpp GeoCoords.hpp \
	Geodesic.hpp GeodesicLine.hpp

INSTALL = install -b
PREFIX = /usr/local
DEST = $(PREFIX)/bin

list:
	@echo $(addsuffix .cpp,$(PROGRAMS)) $(addsuffix .pod,$(PROGRAMS)) \
	$(addsuffix .usage,$(PROGRAMS))

install: $(PROGRAMS)
	test -f $(DEST) || mkdir -p $(DEST)
	$(INSTALL) $^ $(DEST)

