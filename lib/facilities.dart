import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'facilities_details_page.dart';

class FacilitiesPage extends StatefulWidget {
  @override
  _FacilitiesPageState createState() => _FacilitiesPageState();
}

class _FacilitiesPageState extends State<FacilitiesPage> {
  final List<Map<String, String?>> facilities = [
    {"name": "The Sandbox at VBGB", "location": "920 Hamilton St, Charlotte, NC 28206", "surface": "Sand", "courts": "5", "organization": "Sportslink", "website": "https://sportslinkus.com/court-rentals", "rental": "Required", "image": null},
    {"name": "Thirsty Social Club", "location": "508 Woodlawn St, Belmont, NC 28206", "surface": "Sand", "courts": "4", "organization": "Sportslink", "website": "https://sportslinkus.com/court-rentals", "rental": "Required", "image": null},
    {"name": "Small Bar", "location": "3415 Sc-51, Fort Mill, SC 29715", "surface": "Sand", "courts": "3", "organization": "LKN Crew, Charlotte Beach Juniors Volleyball", "website": "https://www.facebook.com/lkn.crew.14", "rental": "None", "image": null},
    {"name": "Sports Connection - Granite Street", "location": "10930 Granite St, Charlotte, NC 28273", "surface": "Indoor", "courts": "8", "organization": "Sports Connection, CJV (Carolina Juniors Volleyball), Carolina Beach Volleyball Academy", "website": "https://sportsconnectionnc.com/sports-rentals/volleyball-open-play/", "rental": "Required", "image": null},
    {"name": "Sports Connection - Northlake", "location": "8626 Hankins Road, Charlotte, NC 28269", "surface": "Indoor", "courts": "2", "organization": "Sports Connection, CJV (Carolina Juniors Volleyball), Carolina Beach Volleyball Academy, CETS, Pyro Volleyball, LKN Crew", "website": "https://sportsconnectionnc.com/sports-rentals/volleyball-open-play/", "rental": "Required", "image": null},
    {"name": "Blythe Landing Park", "location": "8000 Blythe Landing Rd, Charlotte, NC 28273", "surface": "Sand", "courts": "4", "organization": "Mecklenburg County Park and Recreation", "website": "https://www.visitlakenorman.org/listing/blythe-landing/177/", "rental": "Optional", "image": null},
    {"name": "Jeff Adams Tennis Center", "location": "1200 W Tyvola Rd, Charlotte, NC 28217", "surface": "Indoor", "courts": "9", "organization": "Mecklenburg County Park and Recreation", "website": "https://parkandrec.mecknc.gov/Activities/tennis-pickleball-volleyball", "rental": "Optional", "image": null},
    {"name": "Renaissance Park", "location": "1200 W Tyvola Rd, Charlotte, NC 28217", "surface": "Grass", "courts": "7", "organization": "Mecklenburg County Park and Recreation, Kumquats Social", "website": "https://parkandrec.mecknc.gov/Activities/tennis-pickleball-volleyball", "rental": "Optional", "image": null},
    {"name": "Freedom Park", "location": "1900 East Blvd, Charlotte, NC 28203", "surface": "Grass", "courts": "24", "organization": "Mecklenburg County Park and Recreation", "website": "https://www.charlottesgotalot.com/things-to-do/outdoors-adventure/freedom-park", "rental": "Optional", "image": null},
    {"name": "Clarks Creek Park", "location": "5435 Hucks Rd, Charlotte, NC 28269", "surface": "Grass", "courts": "4", "organization": "Mecklenburg County Park and Recreation", "website": "https://www.yelp.ca/biz/clarks-creek-community-park-charlotte", "rental": "Optional", "image": null},
    {"name": "Park Road Park", "location": "6220 Park Rd, Charlotte, NC 28210", "surface": "Sand", "courts": "1", "organization": "Mecklenburg County Park and Recreation", "website": "https://www.yelp.com/biz/park-road-park-charlotte?osq=volleyball+courts&q=volleyball", "rental": "None", "image": null},
    {"name": "Hornets Nest Park", "location": "6301 Beatties Ford Rd, Charlotte, NC 28216", "surface": "Sand", "courts": "2", "organization": "Mecklenburg County Park and Recreation", "website": "https://www.yelp.com/biz/hornets-nest-park-charlotte?osq=volleyball+courts", "rental": "None", "image": null},
    {"name": "Clanton Park", "location": "1520 Clanton Rd, Charlotte, NC 28208", "surface": "Grass", "courts": "4", "organization": "Mecklenburg County Park and Recreation", "website": "https://parkandrec.mecknc.gov/current-projects/park-projects/clanton-park-improvements", "rental": "Optional", "image": null},
    {"name": "MLK Park", "location": "950W 5th St, Charlotte, NC 28202", "surface": "Grass", "courts": "4", "organization": "Mecklenburg County Park and Recreation", "website": "https://www.yelp.com/biz/martin-luther-king-park-charlotte", "rental": "Optional", "image": null},
    {"name": "George Poston Park", "location": "1101 Lowell Spencer Mountain Rd, Gastonia, NC 28056", "surface": "Sand", "courts": "1", "organization": "Gaston County Parks and Recreation", "website": "https://www.gastongov.com/facilities/facility/details/georgepostonpark-6", "rental": "None", "image": null},
    {"name": "Latta Park", "location": "601 East Park Ave, Charlotte, NC 28203", "surface": "Grass", "courts": "4", "organization": "Mecklenburg County Park and Recreation", "website": "https://www.charlottesgotalot.com/things-to-do/outdoors-adventure/latta-park", "rental": "Optional", "image": null},
    {"name": "Tuckaseegee Park", "location": "4820 Tuckaseegee Rd, Charlotte, NC 28208", "surface": "Grass", "courts": "4", "organization": "Mecklenburg County Park and Recreation", "website": "https://parkandrec.mecknc.gov/Places-to-Visit/Rec-Centers/tuckaseegee-recreation-center", "rental": "Optional", "image": null},
    {"name": "CUVC (Carolina Union Volleyball Club)", "location": "11100 Johnnycake Rd, Charlotte, NC 28277", "surface": "Indoor", "courts": "6", "organization": "CUVC (Carolina Union Volleyball Club), Sportslink, LKN Crew", "website": "https://carolinauvc.com/club/facility-information", "rental": "Required", "image": null},
    {"name": "First Baptist Church of Charlotte", "location": "301 S Davidson St, Charlotte, NC 28202", "surface": "Indoor", "courts": "1", "organization": "First Baptist Church of Charlotte", "website": "https://charlottefbc.org/youngadults", "rental": "None", "image": null},
    {"name": "Eastway Regional Recreation Center", "location": "3150 Eastway Park Dr, Charlotte, NC 28213", "surface": "Indoor", "courts": "6", "organization": "Mecklenburg County Park and Recreation", "website": "https://maps.app.goo.gl/24yoqcw8TttepmBKA", "rental": "Required", "image": null},
    {"name": "IBRC (Ivory Baker Recreation Center)", "location": "1920 Stroud Park Court, Charlotte, NC 28206", "surface": "Indoor", "courts": "1", "organization": "Mecklenburg County Park and Recreation", "website": "https://apm.activecommunities.com/mecklenburgparks/Facility_Search?facility_id=148&go_legacy_facility_detail=true", "rental": "Required", "image": null},
    {"name": "Sportsplex at Matthews", "location": "5841 Brookshire Blvd, Charlotte, NC 28216", "surface": "Grass", "courts": "60", "organization": "Mecklenburg County Park and Recreation", "website": "https://maps.app.goo.gl/TrtNkRBj9mWVLBdv6", "rental": "Required", "image": null},
    {"name": "Southside Park", "location": "2645 Toomey Ave, Charlotte, NC 28203", "surface": "Grass", "courts": "24", "organization": "Mecklenburg County Park and Recreation, CAAVL (Charlotte Area Architect's Volleyball League)", "website": "https://maps.app.goo.gl/hRgk57sHK6Tvbxk18", "rental": "Optional", "image": null},
    {"name": "Veterans Park", "location": "2136 Central Ave, Charlotte, NC 28205", "surface": "Grass", "courts": "18", "organization": "Mecklenburg County Park and Recreation, CAAVL (Charlotte Area Architect's Volleyball League), Kumquats Social", "website": "https://maps.app.goo.gl/meDksZCkK8F1twmm7", "rental": "Optional", "image": null},
    {"name": "Independence Park", "location": "300 Hawthorne Ln, Charlotte, NC 28204", "surface": "Grass", "courts": "4", "organization": "Mecklenburg County Park and Recreation, Kumquats Social", "website": "https://maps.app.goo.gl/4KFhHaWG2QmR3Kzx8", "rental": "Optional", "image": null},
    {"name": "Chestnut Square Park", "location": "320 Chestnut Pkwy, Indian Trail, NC 28079", "surface": "Sand", "courts": "4", "organization": "Indian Trail Town Parks and Facilities", "website": "https://www.indiantrail.org/Facilities/Facility/Details/Chestnut-Square-Park-1", "rental": "Optional", "image": null},
    {"name": "Carolina Courts - Concord", "location": "24 Spring St. SW, Concord, NC 28025", "surface": "Indoor", "courts": "8", "organization": "Carolina Courts", "website": "https://www.carolinacourts.com/sevavolleyball", "rental": "Required", "image": null},
    {"name": "Carolina Courts - Indian Trail", "location": "240 Chestnut Pkwy, Indian Trail, NC 28079", "surface": "Indoor", "courts": "8", "organization": "Carolina Courts, SEVA (South Eastern Volleyball Academy)", "website": "https://www.carolinacourts.com/sevavolleyball", "rental": "Required", "image": null},
    {"name": "Saeed's Bar and Grill", "location": "20832 Catawba Ave, Cornelius, NC 28031", "surface": "Sand", "courts": "2", "organization": "Saeed's Volleyball, GO Charlotte", "website": "https://saeedsvolleyball.com/", "rental": "None", "image": null},
    {"name": "Rama Swim Club", "location": "6109 Wheeler Dr, Charlotte, NC 28211", "surface": "Sand", "courts": "2", "organization": "Rama Swim Club", "website": "https://ramaswimclub.com/volleyball-16/", "rental": "Optional", "image": null},
    {"name": "Mako Beach Volleyball Club", "location": "435 Mazeppa Rd, Mooresville, NC 28115", "surface": "Sand", "courts": "4", "organization": "Mako Beach Volleyball Club", "website": "https://makobeach.com/", "rental": "Required", "image": null},
    {"name": "Northern Regional Recreation Center", "location": "18121 Old Statesville Rd, Cornelius, NC 28031", "surface": "Indoor", "courts": "2", "organization": "Mecklenburg County Park and Recreation", "website": "https://parkandrec.mecknc.gov/places-to-visit/rec-centers/northern-regional-recreation-center", "rental": "Required", "image": null},
    {"name": "Huntersville Rec Center", "location": "11836 Verhoeff Dr, Huntersville, NC 28078", "surface": "Indoor", "courts": "2", "organization": "Huntersville Park and Recreation", "website": "https://www.huntersville.org/3073/Parks-Recreation-Department", "rental": "Required", "image": null},
    {"name": "Rock Hill Sports & Events Center", "location": "326 Technology Center Way, Rock Hill, SC 29730", "surface": "Indoor", "courts": "16", "organization": "York County Park and Recreation", "website": "https://www.visityorkcounty.com/things-to-do/sports-recreation/", "rental": "Required", "image": null},
    {"name": "Mallard Creek Park Soccer Fields", "location": "3001 Johnston Oehler Rd, Charlotte, NC 28269", "surface": "Grass", "courts": "24", "organization": "Mecklenburg County Park and Recreation, Pyro Volleyball", "website": "https://www.ayso605.com/Default.aspx?tabid=850442", "rental": "Optional", "image": null},
    {"name": "Mallard Creek Park Volleyball Sand Court", "location": "3001 Johnston Oehler Rd, Charlotte, NC 28269", "surface": "Sand", "courts": "1", "organization": "Mecklenburg County Park and Recreation", "website": "https://maps.app.goo.gl/izPVV3LoTdfzWxBX9", "rental": "None", "image": null},
    {"name": "Hickory Grove Recreation Center", "location": "6709 Pence Rd, Charlotte, NC 28215", "surface": "Indoor", "courts": "2", "organization": "Mecklenburg County Park and Recreation", "website": "https://parkandrec.mecknc.gov/Places-to-Visit/Rec-Centers/hickory-grove-recreation-center", "rental": "Required", "image": null},
    {"name": "JWU Wildcat Center", "location": "235 S Cedar St, Charlotte, NC 28202", "surface": "Indoor", "courts": "0", "organization": "JWU (Johnson & Wales University)", "website": "https://charlotte.jwuathletics.com/index.aspx", "rental": "Required", "image": null},
    {"name": "UNC Charlotte Belk Gym", "location": "8911 University Road, Charlotte, NC 28262", "surface": "Indoor", "courts": "2", "organization": "UNC Charlotte University", "website": "https://urec.charlotte.edu/belk-gym", "rental": "None", "image": null},
    {"name": "UREC (UNC Charlotte University Recreation Center)", "location": "8827 Craver Rd, Charlotte, NC 28262", "surface": "Indoor", "courts": "2", "organization": "UNC Charlotte University", "website": "https://urec.charlotte.edu/open-recreation", "rental": "Required", "image": null},
    {"name": "UREC (UNC Charlotte University Recreation Center)", "location": "8827 Craver Rd, Charlotte, NC 28262", "surface": "Sand", "courts": "1", "organization": "UNC Charlotte University", "website": "https://urec.charlotte.edu/open-recreation", "rental": "Required", "image": null},
    {"name": "Anne Springs Close Greenway", "location": "2573 Lake Haigler Dr, Fort Mill, SC 29715", "surface": "Grass", "courts": "6", "organization": "LKN Crew", "website": "https://www.ascgreenway.org/visit/gatewaycanteen/", "rental": "Required", "image": null}, {"name": "Frank Liske Park & Soccer Complex", "location": "4001 Stough Rd Concord, NC 28027", "surface": "Sand", "courts": "4", "organization": "Cabarrus County Parks & Recreation", "website": "https://www.cabarruscounty.us/Parks/Frank-Liske-Park", "rental": "Optional", "image": null},
    {"name": "William R. Davie Park", "location": "4635 Pineville-Matthews Rd, Charlotte, NC 28226", "surface": "Sand", "courts": "1", "organization": "Mecklenburg County Park and Recreation", "website": "https://www.yelp.com/biz/mecklenburg-county-william-r-davie-park-charlotte?osq=volleyball+courts&q=volleyball", "rental": "None", "image": null},

  ];

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(int index) async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        facilities[index]["image"] = pickedFile.path;
      });
    }
  }

  void _navigateToDetails(Map<String, String?> facility) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FacilityDetailsPage(facility: facility),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Facilities"),
      ),
      body: ListView.builder(
        itemCount: facilities.length,
        itemBuilder: (context, index) {
          final facility = facilities[index];
          return ListTile(
            leading: GestureDetector(
              onTap: () {
                _pickImage(index);
              },
              child: Container(
                width: 50,
                height: 50,
                color: Colors.grey[300],
                child: facility["image"] == null
                    ? const Icon(Icons.add_photo_alternate, size: 30, color: Colors.grey)
                    : Image.file(
                  File(facility["image"]!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: TextButton(
              onPressed: () {
                _navigateToDetails(facility);
              },
              child: Text(
                facility["name"]!,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
