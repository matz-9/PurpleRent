package purpleRent;

import java.sql.*;
import java.util.Scanner;

public class PurpleRent 
{		
		private static String username = "root";
		private static String password = "YourPassword";  // modificare il campo con la propria password mySql
		private static String connString = "jdbc:mysql://localhost:3306/purpleRent?useUnicode=true&characterEncoding=utf8&useSSL=false&useLegacyDatetimeCode=false&serverTimezone=UTC";
		private static Statement command;
		private static ResultSet data;
		private static Connection conn;
		private static Scanner sc;
		private static PreparedStatement updateCommand;
		
		
		public static void menuPrincipale() {
			
			System.out.println("Benvenuto nella nostra applicazione! \n");
			System.out.println("Seleziona una delle seguenti categorie di funzioni: \n");
	        System.out.println("1) Gestione Contratti/Prenotazioni \n"); //OP 1 2 3 4 24
	        System.out.println("2) Gestione Autovetture \n");// 7 10 11 13 14 16 17 18 21 22
	        System.out.println("3) Gestione Clientela \n"); // 9 12 20 23
	        System.out.println("4) Sedi ed Aziende \n"); // 5 6  8 15 19
	        System.out.println("5) Chiudi Applicazione \n");

	        sc = new Scanner(System.in);

	        switch(sc.nextInt()) 
	        {
	        
	        	case 1: gestioneContPren(); break;  // 1 2 3 4 24
	        
	        	case 2: gestioneAutovetture(); break; // 7 10 11 13 14 16 17 18 21 22
	        	
	        	case 3: gestioneClienti(); break;   // 9 12 20 23
	        	
	        	case 4: sediAziende(); break; // 5 6  8 15 19
	        
	        	case 5: System.out.println("Applicazione chiusa. Alla prossima!"); break;
	        
	        	default : 
	        	{ 
	        			System.out.println("Hai sbagliato a digitare! \n\n");
	        			menuPrincipale(); 
	        			
	        	} break;
	        }    	
	        	
	    }

		
		public static void gestioneContPren() {
			
			System.out.println();
			System.out.println("1) Visalizza Prenotazione \n");
	        System.out.println("2) Crea Prenotazione \n");
	        System.out.println("3) Visalizza contratto \n");
	        System.out.println("4) Crea nuovo contratto \n");
	        System.out.println("5) Chiudi contratto \n");
	        System.out.println("6) Torna al menu principale \n\n");
	        System.out.println();

	        switch(sc.nextInt()) 
	        {
	            case 1:  
	            {
	            	System.out.println("\n Eseguo visualizzaPrenotazione(\"P07001\"); \n");

	            	visualizzaPrenotazione("P07001"); 

	            } break;
	            
	            case 2:  
	            {
	            	
	            	System.out.println("\n Eseguo creaPrenotazione(\"P07013\", \"2020-05-22 09:00\", \"2020-06-28 09:00\", \"61031\", \"61031\", \"AP1017Y890\", 'E') \n");
	            	
	            	creaPrenotazione("P07013", "2020-05-22 09:00", "2020-06-28 09:00", "61031", "61031", "AP1017Y890", 'E'); 
	            	
	            } break;
	            	
	            case 3:   
	            {
	            	System.out.println("\n Eseguo visualizzaContratto(\"L00003\"); \n");
	            	
	            	visualizzaContratto("L00003"); 
	            	
	            } break;
	            
	            case 4:  
	            {
	            	System.out.println("\n Eseguo creaPrenotazione(\"P07013\" , \"2020-04-05 09:11\" , \"2020-04-09 09:11\" , \"61040\" ,\"41261\" , \"RJ51230KL7\" , 'L') \n");
	            	System.out.println("Eseguo creaLetteraNoleggio(\"L00013\", 2000, \"chiusa\", \"P07013\", \"1233958372\"); \n");
	            	
	            	creaPrenotazione("P07013" , "2020-04-05 09:11" , "2020-04-09 09:11" , "61040" ,"41261" , "RJ51230KL7" , 'L');
	            	creaLetteraNoleggio("L00013", 2000, "chiusa", "P07013", "1233958372"); 
	            	
	            } break;
	            	 
	            case 5:   
	            {
	            	System.out.println("\n Eseguo chiudiLettera(\"L00001\", 1200); \n");
	            	
	            	chiudiLettera("L00001", 1200); 
	            		
	            } break;
	            
	            case 6:   menuPrincipale(); break;
	        }
			
	        System.out.println();
	    	System.out.println("\n Query eseguita, continuare?");
	    	System.out.println("1) Si");
	    	System.out.println("2) No, torna al menu principale \n");
	    	System.out.println();
	    	
	    	if (sc.nextInt() == 1)
	    		gestioneContPren();
	    	
	    	else
	    		menuPrincipale();
			
		}
		
		
		public static void gestioneAutovetture() {
			
			System.out.println();
			System.out.println("1) CarGroup piu richiesto 2019 \n");
	        System.out.println("2) Varia i prezzi di tutti i car group \n");
	        System.out.println("3) Calcola la somma incassi 2019 diviso per carGroup \n");
	        System.out.println("4) Verifica la sede attuale di una vettura \n");
	        System.out.println("5) Casa automobilistica con piu vetture noleggiabili \n");
	        System.out.println("6) Vetture attualmente in vendita \n");
	        System.out.println("7) Cambia sede di una vettura \n");
	        System.out.println("8) Visualizza riparazioni effettuate \n");      
	        System.out.println("9) Inserisci una riparazione effettuata in una nuova officina\n");
	        System.out.println("10) Inserisci una riparazione effettuata \n");
	        System.out.println("11) Torna al menu principale \n\n");
	        
	        switch(sc.nextInt()) 
	        {
	            case 1: carGroupPiuRichiesto(); break; 
	            
	            case 2:
	            {
	            	System.out.println("Eseguo modificaPrezzo(20)");
	            	
	            	modificaPrezzo(20);  
	            	
	            } break; 
	            	
	            case 3: incassoCarGroup(); break; 
	            
	            case 4:
	            {
	            	System.out.println("Eseguo trovaSede(\"FR249GG\")");
	            	
	            	trovaSede("FR249GG");   
	            	
	            } break; 
	            
	            case 5: casaAutoFlotta(); break; 
	            
	            case 6: nonVendute(); break; 
	            
	            case 7:
	            {
	            	System.out.println("Eseguo cambiaSede(\"61031\",\"FQ647JK\")");
	            	
	            	cambiaSede("61031","FQ647JK"); 
	            	
	            } break; 
	            
	            case 8:
	            {
	            	System.out.println("Eseguo visualizzaRiparazioni(\"EK647FM\")");
	            	
	            	visualizzaRiparazioni("EK647FM"); 
	            	
	            } break; 
	            
	            case 9:
	            {
	            	System.out.println("Eseguo nuovaRiparazioneOfficina(\"weez srl\",\"08:00\" ,\"19:00\" , \"3356974196\" , \"filippolos@filppo.it\" , \"R0015\" ,\"2020-01-14\" , \"convergenza\" , 18.00 , \"ER245GG\")");
	            	
	            	nuovaRiparazioneOfficina("weez srl","08:00" ,"19:00" , "3356974196" , "filippolos@filppo.it" , "R0015" ,"2020-01-14" , "convergenza" , 18.00 , "ER245GG"); 
	            
	            } break; 
	            
	            case 10:
	            {
	            	System.out.println("Eseguo nuovaRiparazione(\"Ncm carrozzeria\", \"R0017\" ,\"2020-01-14\" , \"convergenza\" , 18.00 , \"ER245GG\")");
	            	
	            	nuovaRiparazione("Ncm carrozzeria", "R0017" ,"2020-01-14" , "convergenza" , 18.00 , "ER245GG");
	            	
	            } break; 
	            
	            case 11: menuPrincipale(); break;
	        }
	    	
	    	System.out.println("\n Query eseguita, continuare?");
	    	System.out.println("1) Si");
	    	System.out.println("2) No, torna al menu principale \n");
	    	
	    	if (sc.nextInt() == 1)
	    		gestioneAutovetture();
	    	else
	    		menuPrincipale();
	    	
		}
		
		
		public static void gestioneClienti() {
			
			System.out.println();
			System.out.println("1) Estrai dati bancari da una lettera di noleggo \n");
	        System.out.println("2) Recapiti dei clienti fidati \n");
	        System.out.println("3) Estrai città con maggior numero di clienti e con la relativa sede preferita \n");   // 9 12 20 23
	        System.out.println("4) Inserisci un nuovo cliente e informazioni bancarie \n");
	        System.out.println("5) Torna al menu principale \n\n");
	        
	        switch(sc.nextInt()) 
	        {
	            case 1:
	            {
	            	System.out.println("Eseguo estraiConto(\"L00006\")");
	            	
	            	estraiConto("L00006");     
	            	
	            } break;
	            
	            case 2:  clientiFidati();           break;
	            	
	            case 3:  sedePrefCittàMaxClienti(); break;
	            
	            case 4:  
	            {
	            	System.out.println("Eseguo nuovoCliente(\"AP3015J820\", \"Meo\", \"Isano\", 30, \"4243358375\", \"visa\", \"Unicredit\")");
	            	
	            	nuovoCliente("AP3015J820", "Meo", "Isano", 30, "4243358375", "visa", "Unicredit"); 
	            	
	            }break;
	            
	            case 5:  menuPrincipale();          break;            	   
	        }
	        
	        System.out.println("\n Query eseguita, continuare?");
	    	System.out.println("1) Si");
	    	System.out.println("2) No, torna al menu principale \n");
	    	
	    	if (sc.nextInt() == 1)
	    		gestioneClienti();
	    	else
	    		menuPrincipale();	
			
		}
		
		
		public static void sediAziende() {
			
			System.out.println();
			System.out.println("1) Fornitori che vendono BMW gruppo H \n");
	        System.out.println("2) Estrai sede con maggior numero di ritiri \n");
	        System.out.println("3) Aziende che forniscono il Top Car Group of The Year \n");  // 5 6  8 15 19
	        System.out.println("4) Aziende che hanno speso almeno 10k in una fattura  \n");
	        System.out.println("5) Sedi con buon Feedback (3 e più) \n");
	        System.out.println("6) Torna al menu principale \n\n");
	        
	        switch(sc.nextInt()) 
	        {
	            case 1:  trovaFornitori();      break;
	            
	            case 2:  trovaSedeMaxRitiri();  break;
	            	
	            case 3:  aziendaTopCarGroup();  break;
	            
	            case 4:  fattureDieciK();       break;
	            
	            case 5:  trovaSRitiroVoto4();   break;

	            case 6:  menuPrincipale();      break;          	    
	        }
	        
	        System.out.println("\n Query eseguita, continuare?");
	    	System.out.println("1) Si");
	    	System.out.println("2) No, torna al menu principale");
	    	
	    	if (sc.nextInt() == 1)
	    		sediAziende();
	    	else
	    		menuPrincipale();
		}
		
		
		
		/*
		 * OPERAZIONE 1
		 * 
		 * Visualizza, data una prenotazione, dati cliente e sedi associate
		 */
		// Esempio
		//
		public static void visualizzaPrenotazione(String numPrenotazione) {
			
			try {
				
				// eseguo la query
				data = command.executeQuery("{call visualizzaPrenotazione(\""+ numPrenotazione +"\")}");
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				
			}
				System.out.println("+------+---------+-----------+-------------+---------------+");
				System.out.println("| NOME | COGNOME | DOCUMENTO | SEDE_RITIRO | SEDE_RILASCIO |");
				System.out.println("+------+---------+-----------+-------------+---------------+");
				
				try {
					
					while (data.next()) {
						
						String nome = data.getString("nome");
						String cognome = data.getString("cognome");
						String numDocumento = data.getString("numDocumento");
						String sedeRitiro = data.getString("sedeRitiro"); 
						String sedeRilascio = data.getString("sedeRilascio");
						
						System.out.println("| " + nome +" | " + cognome + " | " + numDocumento + " | " + sedeRitiro + " | " + sedeRilascio + " | " );
						
						}
					
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
		
		
		/*
		 * OPERAZIONE 2
		 * 
		 * Effettua una prenotazione
		 */
		// Esempio 
		// creaPrenotazione("P07013", "2020-05-22 09:00", "2020-06-28 09:00", "61031", "61031", "AP1017Y890", 'E');
		public static void creaPrenotazione(String numeroP,String orarioIn ,String orarioFi, String sedeRit, String sedeRil, String cliente, char gruppo) {
			try {
				
				data = command.executeQuery("{call creaPrenotazione(\""+ numeroP +"\", \""+ orarioIn  +"\", \""+ orarioFi +"\", \""+ sedeRit +"\", \""+ sedeRil +"\", \""+ cliente +"\", '"+ gruppo + "')}");	
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				
				System.out.println("Done"); 
			}
		}
		
		
		
		/*
		 * OPERAZIONE 3
		 * 
		 * Visualizza lettera di noleggio,prenotazione associata e autovettura assegnata
		 */
		// Esempio 
		// visualizzaContratto("L00003");
		public static void visualizzaContratto(String contratto) {
			
			try {
				
				// eseguo la query
				data = command.executeQuery("{call visualizzaContratto(\""+ contratto +"\")}");
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
		
			}
			
			System.out.println("+------------------+-------------+--------+--------------+---------+-------------+");
			System.out.println("| NUMERO_CONTRATTO | KM_PERCORSI | TIPO   | PRENOTAZIONE | TARGA   | CASA_AUTO   |");
			System.out.println("+------------------+-------------+--------+--------------+---------+-------------+");
			
			try {
				
				while (data.next()) {
					
					String numeroLettera = data.getString(1);
					String kmPercorsi = data.getString(2);
					String tipo = data.getString(3);
					String prenotazione = data.getString(4); 
					String targa = data.getString(5);
					String casaAuto = data.getString(6);
					
					System.out.println("| " + numeroLettera +"           | " + kmPercorsi + "         | " + tipo + " | " + prenotazione + "       | " + targa + " | "+ casaAuto + "   |" );
					
					}
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				System.out.println("+------------------+-------------+--------+--------------+---------+-------------+");
			}
			
		}
		
		
		
		/*
		 * OPERAZIONE 4 
		 * 
		 * Crea un lettera di noleggio associata ad una prenotazione assegnando 
		 * una autovettura (aggiornando la disponibilità attuale) e i dati bancari per il pagamento.
		 */
		// Esempio: 
		// creaPrenotazione("P07013" , "2020-04-05 09:11" , "2020-04-09 09:11" , "61040" ,"41261" , "RJ51230KL7" , 'L');
		// creaLetteraNoleggio("L00013", 2000, "chiusa", "P07013", "1233958372");
		public static void creaLetteraNoleggio(String numeroLettera, int kmPercorsi, String tipo, String prenotazione, String datiBancari) {
			
			try {
				
				// eseguo la query
				data = command.executeQuery("{call creaLetteraNoleggio(\""+ numeroLettera +"\", \""+ kmPercorsi +"\", \""+ tipo +"\", \""+ prenotazione +"\", \""+ datiBancari + "\")}");
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				System.out.println("Done");
			}	
				
		}
		
		
		
		/*
		 * OPERAZIONE 5
		 * 
		 * Trova fornitori che vendono un’autovettura BMW gruppo H
		 */
		// Esempio 
		// trovaFornitori()
		public static void trovaFornitori() {
			try {
				
				// eseguo la query
				data = command.executeQuery("{call trovaFornitori()}");
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				
				System.out.println("+----------------+");
				System.out.println("| NOME FORNITORE |");
				System.out.println("+----------------+");
				
				try {
					
					while (data.next()) {
						
						String nomeAziendaFornitore = data.getString("nomeAziendaFornitore");
						
						System.out.println("| " + nomeAziendaFornitore +" |" );	
					}
					
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
				
			}
		}
		
		
		
		/*
		 * OPERAZIONE 6
		 * 
		 * Estrai il nome della sede con il maggior numero di ritiri autovetture
		 */
		// Esempio
		// trovaSedeMaxRitiri()
		public static void trovaSedeMaxRitiri() {
			
			try {
				
				// eseguo la query
				data = command.executeQuery("{call trovaSedeMaxRitiri()}");
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				
				System.out.println("+------+-------+-----+");
				System.out.println("| SEDE | CITTA | NUM |");
				System.out.println("+------+-------+-----+");
				
				try {
					
					while (data.next()) {
						
						String sede = data.getString(1);
						String città = data.getString(2);
						String num = data.getString(3);
						
						System.out.println("| " + sede +" | "+ città +" | "+ num +" |");	
					}
					
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
				
			}
		}

		
		
		/*
		 * OPERAZIONE 7
		 * 
		 * Identifica il car group più richiesto nel 2019
		 */
		// Esempio
		// carGroupPiuRichiesto()
		public static void carGroupPiuRichiesto() {
			
			try {
				
				// eseguo la query
				data = command.executeQuery("{call carGroupPiuRichiesto(@res)}");
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				
				System.out.println("+----------+-----------+");
				System.out.println("| CARGROUP | PRENOTATO |");
				System.out.println("+----------+-----------+");
				
				try {
					
					while (data.next()) {
						
						String carGroup = data.getString("carGroup");
						String prenotato = data.getString("prenotato");
						
						System.out.println("|    " + carGroup +"     |     "+ prenotato + "     |");	
						System.out.println("+----------+-----------+");
					}
					
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		
		
		/*
		 * OPERAZIONE 8
		 * 
		 * Estrai i nomi delle aziende che hanno fornito le vetture del car group più richiesto nel 2019 (operazione 7)
		 */
		// Esempio
		// aziendaTopCarGroup()
		public static void aziendaTopCarGroup() {
			
			try {
				
				// eseguo la query
				CallableStatement cstmt = conn.prepareCall("{call aziendaTopCarGroup()}");
				@SuppressWarnings("unused")
				ResultSet rs1 = cstmt.executeQuery(); 	// prima query
				cstmt.getMoreResults(); 				// vado avanti
				ResultSet rs2 = cstmt.getResultSet(); 	// prendo il secondo result set
				
				System.out.println("+---------+----------------------+");
				System.out.println("|  TARGA  |      FORNITORE       |");
				System.out.println("+---------+----------------------+");
				
				try {
					
					while (rs2.next()) {
						
						String targa = rs2.getString(1);
						String nomeAziendaFornitore = rs2.getString(2);
						
						System.out.println("| " + targa +" | "+ nomeAziendaFornitore + "   |");	

					}
					
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			} 
		}
		
		
		
		/*
		 *  OPERAZIONE 9
		 * 
		 *  L’azienda deve riscuotere il pagamento relativo ad un noleggio: 
		 *  estrai il numero del conto corrente associato ad una lettera di noleggio
		 */
		// Esempio
		// estraiConto('L00006')
		public static void estraiConto(String numConto) {
			
			try {
				
				// eseguo la query
				data = command.executeQuery("{call estraiConto(\"" + numConto + "\")}");
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				
				System.out.println("+------+---------+--------------+-------------+");
				System.out.println("| NOME | COGNOME | DATI_BANCARI | NUM_LETTERA |");
				System.out.println("+------+---------+--------------+-------------+");
				
				try {
					
					while (data.next()) {
						
						String nome = data.getString(1);
						String cognome = data.getString(2);
						String datiBancari = data.getString(3);
						String numeroLettera = data.getString(4);
						
						System.out.println("| " + nome +" | "+ cognome +"   | "+ datiBancari +"   | " + numeroLettera + "      |");	
						System.out.println("+------+---------+--------------+-------------+");
					}
					
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
				
			}
			
		}
		
		
		
		/*
		 *  OPERAZIONE 10
		 *  
		 *  Varia i prezzi di tutti i car group di una certa cifra:
		 *  il prezzo sarà aumentato sommando il vecchio valore al nuovo passato in input 
		 *  (con valore positivo si aumenta il prezzo, con valore negativo si diminuisce)
		 */
		// call modificaPrezzo(20);
		//
		public static void modificaPrezzo(int val) {
			
			try {
				
				// eseguo la query
				data = command.executeQuery("{call modificaPrezzo(" + val + ")}");
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				System.out.println("Done");
			 }	
			
		}
		
		
		
		/*
		 *  OPERAZIONE 11
		 *  
		 *  Calcola la somma del denaro previsto incassato dalle prenotazioni 
		 *  nell’ultimo anno per ogni tipologia di Car group
		 */
		// Esempio
		// incassoCarGroup();
		public static void incassoCarGroup() {
			
			try {
				
				// eseguo la query
				data = command.executeQuery("{call incassoCarGroup()}");
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				
			}
				System.out.println("+----------+--------+");
				System.out.println("| CARGROUP | TOTALE |");
				System.out.println("+----------+--------+");
				
				try {
					
					while (data.next()) {
						
						String carGroup = data.getString("carGroup");
						String totale = data.getString("totale");
						
						System.out.println("| " + carGroup +"        | " + totale + "  |" );
						
						}
					
				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					System.out.println("+----------+--------+");
				}
			
		}
		
		
		
		/*
		 * OPERAZIONE 12
		 * 
		 *  L’azienda propone delle offerte, reperisci i contatti telefonici
		 *  dei clienti che hanno effettuato nell’ultimo anno almeno due 
		 *  prenotazioni e di età maggiore di 45
		 */
		// Esempio
		// clientiFidati();
		public static void clientiFidati() {
			
			try {
				
				// eseguo la query
				data = command.executeQuery("{call clientiFidati()}");
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				
			}
				System.out.println("+----------+----------+--------------+");
				System.out.println("| NOME     | COGNOME  | PRENOTAZIONI |");
				System.out.println("+----------+----------+--------------+");
				
				try {
					
					while (data.next()) {
						
						String nome = data.getString("nome");
						String cognome = data.getString("cognome");
						String pren = data.getString("pren");
						
						if (data.getRow() == 1) System.out.println("| " + nome +"    | " + cognome + "    | " + pren + "            |" );
						if (data.getRow() == 2) System.out.println("| " + nome +" | " + cognome + " | " + pren + "            |" );
						if (data.getRow() == 3) System.out.println("| " + nome +"    | " + cognome + "  | " + pren + "            |" );
						if (data.getRow() == 4) System.out.println("| " + nome +"     | " + cognome + "  | " + pren + "            |" );
						}
					
				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					System.out.println("+----------+----------+--------------+");
				}
			
		}
		
		
		
		/*
		 * OPERAZIONE 13
		 * 
		 * Verifica la sede attuale di un'autovettura
		 */
		// Esempio
		//trovaSede("FR249GG");
		public static void trovaSede(String targa) {
			
			try {
				
				// eseguo la query
				data = command.executeQuery("{call trovaSede(\"" + targa + "\")}");
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				
				System.out.println("+-------+---------+");
				System.out.println("| SEDE  | CITTA   |");
				System.out.println("+-------+---------+");
				
				try {
					
					while (data.next()) {
						
						String sede = data.getString(1);
						String città = data.getString(2);
						
						System.out.println("| " + sede +" | "+ città +" |");	
				
					}
					
				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					System.out.println("+-------+---------+");
				}	
			}
			
		}
		
		
		
		/*
		 * OPERAZIONE 14
		 * 
		 * Individua la casa automobilistica a cui appartengono il maggior numero di 
		 * autovetture noleggiabili della flotta dell’azienda
		 */
		// Esempio
		// casaAutoFlotta();
		public static void casaAutoFlotta() {
			
			try {
				
				data = command.executeQuery("{call casaAutoFlotta()}");
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				
				System.out.println("+-----------+------+");
				System.out.println("| CARGROUP  | TOT  |");
				System.out.println("+-----------+------+");
				
				try {
					
					while (data.next()) {
						
						String carGroup = data.getString(1);
						String totale = data.getString(2);
						
						System.out.println("| " + carGroup +"     | "+ totale +" |");	
				
					}
					
				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					System.out.println("+-----------+------+");
				}	
			}
			
		}
		
		
		
		/*
		 * OPERAZIONE 15
		 * 
		 * Estrai i nomi e p.iva delle aziende che hanno acquistato vetture con una fattura 
		 * di valore superiore a 10.000 euro
		 */
		// Esempio
		// fattureDieciK();
		public static void fattureDieciK() {
			
			try {
				
				data = command.executeQuery("{call fattureDieciK()}");
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				
				System.out.println("+-----------------+");
				System.out.println("| AZIENDA         |");
				System.out.println("+-----------------+");
				
				try {
					
					while (data.next()) {
						
						String nomeAzienda = data.getString(1);
						
						System.out.println("| " + nomeAzienda +" |");	
				
					}
					
				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					System.out.println("+-----------------+");
				}	
			}
			
		}
		
		
		
		/*
		 * OPERAZIONE 16
		 * 
		 * Estrai la targa delle autovetture in vendita, ma non ancora vendute
		 */
		// Esempio
		// nonVendute();
		public static void nonVendute() {
			
			try {
				
				data = command.executeQuery("{call nonVendute()}");
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				
				System.out.println("+--------+--------+----------------+-----------+");
				System.out.println("| TARGA  | COLORE | PREZZO_VENDITA | CASA_AUTO |");
				System.out.println("+--------+--------+----------------+-----------+");
				
				try {
					
					while (data.next()) {
						
						String targa = data.getString(1);
						String colore = data.getString(2);
						String prezzoVendita = data.getString(3);
						String casaAuto = data.getString(4);
						
						System.out.println("| " + targa +" | "+ colore +" | "+ prezzoVendita +" | "+ casaAuto +" |");	
				
					}
					
				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					System.out.println("+--------+--------+----------------+-----------+");			}	
			}
			
		}
		
		
		
		/*
		 * OPERAZIONE 17
		 * 
		 * Cambia la sede attuale di un’autovettura
		 */
		// Esempio
		// cambiaSede("61031","FQ647JK");
		public static void cambiaSede(String nuovaSede, String auto) {
			
			try {
				
				String q = "{call cambiaSede(\"" + nuovaSede + "\", \""+ auto + "\")}";
				
				updateCommand = conn.prepareStatement(q, Statement.RETURN_GENERATED_KEYS);;
				
				int rows = updateCommand.executeUpdate();
				
				if (rows <= 1) System.out.println("Ok, " + rows + " row affected");
				else System.out.println("Ok, " + rows + " rows affected");
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
		
			}
			
		}
		
		
		
		/*
		 * OPERAZIONE 18
		 * 
		 * Visualizza le riparazioni effettuate su una vettura in vendita, 
		 * inclusa l’officina interessata
		 */
		// Esempio
		// visualizzaRiparazioni("EK647FM");
		public static void visualizzaRiparazioni(String targa) {
			
			try {
				
				// eseguo la query
				data = command.executeQuery("{call visualizzaRiparazioni(\"" + targa + "\")}");
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				
				System.out.println("+-------------+----------+-----------------+-----------------+");
				System.out.println("| NUMERO_RIP  | OFFICINA | ORARIO_APERTURA | ORARIO_CHIUSURA |");
				System.out.println("+-------------+----------+-----------------+-----------------+");
				
				try {
					
					while (data.next()) {
						
						String numeroRip = data.getString(1);
						String officina = data.getString(2);
						String orarioApertura = data.getString(3);
						String orarioChiusura = data.getString(4);
						
						System.out.println("| " + numeroRip +" | "+ officina +" | "+ orarioApertura +" | "+ orarioChiusura +" |");	
				
					}
					
				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					System.out.println("+-------------+----------+-----------------+-----------------+");
				}	
			}
			
		}
		
		
		
		/*
		 * OPERAZIONE 19
		 * 
		 * Visualizza le sedi di ritiro con un voto nel feedback maggiore di 4
		 */
		// Esempio
		// trovaSRitiroVoto4()
		public static void trovaSRitiroVoto4() {
			
			try {
				
				data = command.executeQuery("{call trovaSRitiroVoto4()}");
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				
				System.out.println("+--------------+--------+");
				System.out.println("| SEDE_RITIRO  | CITTA  |");
				System.out.println("+--------------+--------+");
				
				try {
					
					while (data.next()) {
						
						String sedeRitiro = data.getString(1);
						String città = data.getString(2);
						
						System.out.println("| " + sedeRitiro +"        | "+ città +" |");	
				
					}
					
				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					System.out.println("+--------------+--------+");	}	
			}
			
		}
		
		
		
		/*
		 * OPERAZIONE 20
		 * 
		 * Estrai il nome della città con maggior numero di clienti
		 * e con la relativa sede preferita
		 */
		// Esempio
		// sedePrefCittàMaxClienti();
		public static void sedePrefCittàMaxClienti() {
			
			try {
				
				data = command.executeQuery("{call sedePrefCittàMaxClienti()}");
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				
				System.out.println("+-------+-------+---------------+--------+----------+");
				System.out.println("| SEDE  | CITTA | NUM_DOCUMENTO | NOME   | COGNOME  |");
				System.out.println("+-------+-------+---------------+--------+----------+");
				
				try {
					
					while (data.next()) {
						
						String sede = data.getString(1);
						String città = data.getString(2);
						String numDocumento = data.getString(3);
						String nome = data.getString(4);
						String cognome = data.getString(5);
						
						System.out.println("| " + sede +" | "+ città +"  | "+ numDocumento +" | "+ nome +" | "+ cognome +" |");	
				
					}
					
				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					System.out.println("+-------+-------+---------------+--------+----------+");
				}	
			}
			
		}
		
		
		
		/*
		 * OPERAZIONE 21
		 * 
		 * Inserisci una nuova riparazione effettuata in una nuova officina 
		 */
		// Esempio
		// nuovaRiparazione("weez srl","08:00" ,"19:00" , "3356974196" , "filippolos@filppo.it" , "R0015" ,"2020-01-14" , "convergenza" , 18.00 , "ER245GG");
		public static void nuovaRiparazioneOfficina(String nomeOfficina, String orarioAperturaOff,
				String orarioChiusuraOff, String numTelOff, String emailOff, String nRip, String dataRip, 
				String motiv, Double prezzo, String macchina) {
			
				try {
					
					data = command.executeQuery("{call nuovaRiparazioneOfficina(\""+ nomeOfficina +"\", \""+ orarioAperturaOff  +"\", \""+ orarioChiusuraOff +"\", \""+ numTelOff +"\", \""+ emailOff +"\", \""+ nRip +"\", \""+ dataRip + 
							"\",\""+ motiv  +"\", " + prezzo + ", \"" + macchina +"\")}");
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} finally { 
					System.out.println("Done");
				}
			
		}
		
		
		
		/*
		 * OPERAZIONE 22
		 * 
		 * Inserisci una riparazione effettuata in una officina già convenzionata
		 */
		// Esempio
		// nuovaRiparazione("Ncm carrozzeria", "R0017" ,"2020-01-14" , "convergenza" , 18.00 , "ER245GG");
		public static void nuovaRiparazione(String nomeOfficina, String nRip, String dataRip, 
				String motiv, Double prezzo, String macchina) 
		{	
			try 
			{
				
				data = command.executeQuery("{call nuovaRiparazione(\""+ nomeOfficina +"\", \""+ nRip +"\", \""+ dataRip + 
						"\",\""+ motiv  +"\", " + prezzo + ", \"" + macchina +"\")}");
				
			} 
			catch (SQLException e) { e.printStackTrace();}
			
			finally { System.out.println("Done"); }	
		}
		
		
		
		/*
		 * OPERAZIONE 23
		 * 
		 * Inserisci nuovo cliente con dati bancari associati
		 */
		// Esempio
		// nuovoCliente("AP3015J820", "Meo", "Isano", 30, "4243358375", "visa", "Unicredit");
		public static void nuovoCliente(String nDoc, String nome, String cognome, int età, String contoCorr,
	            String circuito, String nomeBanca) {
			
			try {
				
				data = command.executeQuery("{call nuovoCliente(\""+ nDoc +"\", \""+ nome  +"\", \""+ cognome  +"\", " + età + ", \"" + contoCorr +"\", \""+ circuito +"\", \""+ nomeBanca +"\")}");
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally { 
				System.out.println("Done");
			}
			
			
		}
		
		
		/*
		 * OPERAZIONE 23
		 * 
		 * Chiusura di una lettera di noleggio conclusa
		 */
		// Esempio 
		// chiudiLettera("L00001", 1200);
		public static void chiudiLettera(String contratto, int kmPercorsi) {
			
			try {
				
				data = command.executeQuery("{call chiudiLettera(\""+ contratto +"\", " + kmPercorsi + ")}");
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally { 
				System.out.println("Done");
			}
			
		}
		
		public static void main(String[] args) throws SQLException 
		{		
			try 
			{
				conn = DriverManager.getConnection(connString, username, password);
				command = conn.createStatement();
				
				menuPrincipale();		
			}
			catch (SQLException e) { e.printStackTrace(); } 
		}		
 	}
			
				
				
				// OP1
				//visualizzaPrenotazione("P07001");
				
				
				// OP2
				// creaPrenotazione("P07013", "2020-05-22 09:00", "2020-06-28 09:00", "61031", "61031", "AP1017Y890", 'E');	
				
				
				//OP3
				//visualizzaContratto("L00003");
				
				
				// OP4
				// creaPrenotazione("P07014" , "2020-04-05 09:11" , "2020-04-09 09:11" , "61040" ,"41261" , "RJ51230KL7" , 'L');
				// creaLetteraNoleggio("L00013", 2000, "chiusa", "P07014", "1233958372");
				
				
				// OP5
				//trovaFornitori();
				
				
				// OP6
				//trovaSedeMaxRitiri();
				
				
				//OP7
				//carGroupPiuRichiesto();
				
				
				//OP8
				//aziendaTopCarGroup();
				
				
				//OP9
				//estraiConto("L00006");
				
				
				//OP10
				//modificaPrezzo(20);
				
				
				//OP11
				//incassoCarGroup();
				
				
				//OP12
				//clientiFidati();
				
				
				//OP13
				//trovaSede("FR249GG");
				
				
				//OP14
				//casaAutoFlotta();
				
				
				//OP15
				//fattureDieciK();
				
				
				//OP16
				//nonVendute();
				
				
				//OP17
				//cambiaSede("61031","FQ647JK");
				
				
				//OP18
				//visualizzaRiparazioni("EK647FM");
				
				
				//OP19
				//trovaSRitiroVoto4();
				
				
				//OP20
				//sedePrefCittàMaxClienti();
				
				
				//OP21
				//nuovaRiparazioneOfficina("weez srl","08:00" ,"19:00" , "3356974196" , "filippolos@filppo.it" , "R0015" ,"2020-01-14" , "convergenza" , 18.00 , "ER245GG");
				
				
				//OP22
				//nuovaRiparazione("Ncm carrozzeria", "R0017" ,"2020-01-14" , "convergenza" , 18.00 , "ER245GG");
				
				
				//OP23
				//nuovoCliente("AP3015J820", "Meo", "Isano", 30, "4243358375", "visa", "Unicredit");
				
				
				//OP24
				//chiudiLettera("L00001", 1200);
				
