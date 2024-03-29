function stations=getStationsByRoom(conn)
stations = {};
selectStationQuery = ...
    sprintf('SELECT mac, station_id,rack_id,row_num,col_num,ratrixservers.address FROM stations,racks,ratrixservers WHERE stations.rack_uin=racks.uin AND stations.server_uin=ratrixservers.uin ORDER BY room,rack_id,station_id'); 

results=query(conn,selectStationQuery);

if ~isempty(results)
    numRecords=size(results,1);
    stations = cell(numRecords,1);
    for i=1:numRecords
        s = [];
        s.mac = results{i,1};
        s.station_id = results{i,2};
        s.rack_id = results{i,3};
        s.row = results{i,4};
        s.col = results{i,5};
        s.server = results{i,6};
        stations{i} = s;
    end
end
