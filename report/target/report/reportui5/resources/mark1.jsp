
<%@ page contentType="application/pdf" pageEncoding="UTF-8" language="java"%>

<%@ page trimDirectiveWhitespaces="true"%>

<%@ page import="net.sf.jasperreports.engine.*" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.FileNotFoundException" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="de.simplicit.vjdbc.VJdbcProperties" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="net.sf.jasperreports.engine.JasperCompileManager" %>
<%@ page import="net.sf.jasperreports.engine.JasperExportManager" %>
<%@ page import="net.sf.jasperreports.engine.JasperFillManager" %>
<%@ page import="net.sf.jasperreports.engine.JasperPrint" %>
<%@ page import="net.sf.jasperreports.engine.JasperReport" %>
<%@ page import="net.sf.jasperreports.engine.JRException" %>
<%@ page import="net.sf.jasperreports.engine.data.JRBeanCollectionDataSource" %>
<%@ page import="net.sf.jasperreports.engine.design.JasperDesign" %>
<%@ page import="net.sf.jasperreports.engine.xml.JRXmlLoader" %>
<%@ page import="net.sf.jasperreports.fonts.*" %>
<%@ page import="javax.servlet.http.HttpServlet" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>

<%

    Connection conn=null;

    try {
    	
 
        //Connecting to the MySQL database
        
Class.forName( "de.simplicit.vjdbc.VirtualDriver" );
Properties prop = new Properties();
prop.setProperty(VJdbcProperties.LOGIN_USER, "amt_admin");
prop.setProperty(VJdbcProperties.LOGIN_PASSWORD, "Amtsuper1#");
           
       conn =DriverManager.getConnection("jdbc:vjdbc:servlet:https://josde-stage.plateau.com/vjdbc/vjdbc,db10g", prop);

     
        //Loading Jasper Report File from Local file system
       // String path = "newReport.jrxml";
        //String imagePath = "/";
        
       //String path = new String("newReport.jrxml");
      // String imagePath = new String("/");
       
     String path = session.getServletContext().getRealPath("newReport.jrxml");
       //System.out.println(path);
       String imagePath = session.getServletContext().getRealPath("/");
 
    
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
           
      JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());
        
        
    
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

%>