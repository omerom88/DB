import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;


public class Recommend {
	
	private Connection conect;
	private PreparedStatement preStat;
	private ResultSet resSet,rslt,rst,reslt;


	public void init(String username) throws SQLException, ClassNotFoundException {
		
		Class.forName("org.postgresql.Driver");
		String connection = "jdbc:postgresql://pgserver/public?user=" + username;
		conect = DriverManager.getConnection(connection);
	}


	public int[] getRecommendation(int dtype, int userid, int k) throws SQLException{

		Set<Integer> conectDevices = new HashSet<Integer>();
		Set<Integer> userDevices;
		String devicesInfo;
		Set<Integer> conectUsers = findConectUser(userid, k);
		Set<Integer> badType = new HashSet<Integer>();
		List<Integer> sortIt = new ArrayList<Integer>();
		int newDevice;

		for (int user : conectUsers){
			conectDevices.addAll(getDevices(user));
		}
		userDevices = getDevices(userid);
		conectDevices.removeAll(userDevices);

		devicesInfo = "select DISTINCT did from Devices where dtype != ?";
		preStat = conect.prepareStatement(devicesInfo);
		preStat.setInt(1, dtype);
		rst = preStat.executeQuery();

		while(rst.next()) {
			newDevice = rst.getInt(1);
			badType.add(newDevice);
		}
		conectDevices.removeAll(badType);
		sortIt.addAll(conectDevices);
		Collections.sort(sortIt);

		int[] finalList = new int[sortIt.size()];
		int index = 0;
		for (int device : sortIt){
			finalList[index] = device;
			index++;
		}
		return finalList;
	}

	
	public Set<Integer> getNeighberList(int userid) throws SQLException{

		Set<Integer> devices = getDevices(userid);
		Set<Integer> theUsers = new HashSet<Integer>();
		int newUser;

		String usersInfo = "select userid from Ownerships where did = ?";
		preStat = conect.prepareStatement(usersInfo);
		for (int device : devices){
			preStat.setInt(1, device);
			reslt = preStat.executeQuery();
			while(reslt.next()) {
				newUser = reslt.getInt(1);
				theUsers.add(newUser);
			}
		}
		theUsers.remove(userid);
		return theUsers;
	}


	public Set<Integer> findConectUser(int userid, int k) throws SQLException{

		Set<Integer> neighberList = getNeighberList(userid);
		Set<Integer> allConnected = new HashSet<Integer>();

		if (k == 0){
			return new HashSet<Integer>();
		}
		else{
			for (int nieghber : neighberList){
				allConnected.add(nieghber);
				allConnected.addAll(findConectUser(nieghber, k-1));
			}
			return allConnected;
		}
	}


	public Set<Integer> getDevices(int userid) throws SQLException{

		Set<Integer> theDevices = new HashSet<Integer>();
		int newDevice;

		String devicesInfo = "select DISTINCT did from OwnerShips where userid = ?";
		preStat = conect.prepareStatement(devicesInfo);
		preStat.setInt(1, userid);
		rslt = preStat.executeQuery();
		while(rslt.next()) {
			newDevice = rslt.getInt(1);
			theDevices.add(newDevice);
		}
		return theDevices;
	}


	public void close() throws SQLException{
		preStat.close(); conect.close();
		if (resSet != null){
			resSet.close();
		}
	}
}

