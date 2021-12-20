/*
Already created BCP format file with the following command:

bcp HealthStrategy.RawSource.DummyData_Brooke_File1_BCP format nul -c -x -f "C:\Users\Brooke\BCPFormatFile.xml" -t, -T -S DESKTOP-G4V2OAO\SQLEXPRESS
*/


--bcp HealthStrategy.RawSource.DummyData_Brooke_File1_BCP IN "C:\Users\Brooke\Desktop\Skills_Evaluation\DummyData_Brooke_File1.txt" -f "C:\GITProjects\HS-BCP-Solution\BCPFormatFile.xml" -T -S DESKTOP-G4V2OAO\SQLEXPRESS
--bcp HealthStrategy.RawSource.DummyData_Brooke_File2_BCP IN "C:\Users\Brooke\Desktop\Skills_Evaluation\DummyData_Brooke_File2.txt" -f "C:\GITProjects\HS-BCP-Solution\BCPFormatFile.xml" -T -S DESKTOP-G4V2OAO\SQLEXPRESS
