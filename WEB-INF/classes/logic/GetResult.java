/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package logic;

/**
 *
 * @author j1012484
 */
import java.io.*;

public class GetResult {


    public String getBuildNumber(String path) throws IOException{

        String buildNumber = null;
        String result = null;

        try
		   {
			 FileInputStream fis = new FileInputStream(path);
             BufferedReader br = new BufferedReader(new InputStreamReader(fis));

                            buildNumber = br.readLine();
                            result = buildNumber;
            }
		catch(ArrayIndexOutOfBoundsException e)
		{
                       		result = "File Name Missing";

		}
		catch(FileNotFoundException e)
		{
                       		result = "Source File missing";

		}

        return result;
    }
}
