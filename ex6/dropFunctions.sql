drop function getMonthPassed(trackingid integer);
drop function getpopularity(deviceid integer);
drop function getFirmPopularity(firmid integer);


drop trigger dont_trig_devices on Devices;
drop trigger dont_trig_owenrships on OwnerShips;
drop trigger dont_trig_deviceTracking on DeviceTracking;
drop trigger dates_trig on DeviceTracking;
drop trigger update_most_popular_own on DeviceTracking;
drop trigger update_most_popular_trck on Ownerships;
drop trigger change_trig on DeviceTracking;


drop function dont_func();
drop function change_func();
drop function dates_func();
drop function popular_func();

