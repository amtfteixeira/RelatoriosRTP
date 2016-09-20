package com.jsp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import de.simplicit.vjdbc.VJdbcProperties;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.jasperreports.view.JasperViewer;

public class App 
{
 
        Connection conn=null;

        try {
            //Connecting to the MySQL database
            
    Class.forName( "de.simplicit.vjdbc.VirtualDriver" );
    Properties prop = new Properties();
    prop.setProperty(VJdbcProperties.LOGIN_USER, "amt_admin");
    prop.setProperty(VJdbcProperties.LOGIN_PASSWORD, "Amtsuper1#");
               
           conn =DriverManager.getConnection("jdbc:vjdbc:servlet:https://josde-stage.plateau.com/vjdbc/vjdbc,db10g", prop);

         
            //Loading Jasper Report File from Local file system
            String path = "Reports//newReport.jrxml";
            String imagePath = "Reports//";
            
           //String path = new String("newReport.jrxml");
          // String imagePath = new String("/");
           
          //String path = session.getServletContext().getRealPath("newReport.jrxml");
           //System.out.println(path);
          // String imagePath = session.getServletContext().getRealPath("/");
     
        
            Map parameters = new HashMap();
            parameters.put("name", "amt_admin");
            parameters.put("realPath", imagePath);
            
            
           // InputStream input = new FileInputStream(new File(path));

            	//JasperDesign design = JRXmlLoader.load(path);
           	JasperDesign design  = JRXmlLoader.load(path);
            	

            //	JasperReport jasperReport = JasperCompileManager.compileReport(getClass().getResourceAsStream("/newReport.jrxml"));
            //Generating the report
           JasperReport jasperReport = JasperCompileManager.compileReport(design);
        
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, conn);

            //Exporting the report as a PDF
               
         // JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());
            JasperViewer.viewReport(jasperPrint, false);
            
        
        } catch (JRException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            if(conn!=null){
                conn.close();
            }
        }
    }

