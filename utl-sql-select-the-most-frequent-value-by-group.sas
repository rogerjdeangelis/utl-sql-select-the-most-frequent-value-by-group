Create a sas dataset containing just the most frequent values by group                                     
                                                                                                           
github                                                                                                     
https://cutt.ly/agDRN97                                                                                    
https://github.com/rogerjdeangelis/utl-sql-select-the-most-frequent-value-by-group                         
                                                                                                           
StackOverflow                                                                                              
https://cutt.ly/hgDEtvP                                                                                    
https://stackoverflow.com/questions/64615440/choosing-the-mode-of-a-string-by-group-in-sas                 
                                                                                                           
*                                                                                                          
#####  #   #  ####   #   #  #####                                                                          
  #    ##  #  #   #  #   #    #                                                                            
  #    # # #  #   #  #   #    #                                                                            
  #    #  ##  ####   #   #    #                                                                            
  #    #   #  #      #   #    #                                                                            
  #    #   #  #      #   #    #                                                                            
#####  #   #  #       ###     #                                                                            
                                                                                                           
#! INPUT ;                                                                                                 
                                                                                                           
DATA have;                                                                                                 
 INPUT id weekday $;                                                                                       
CARDS4;                                                                                                    
1 Thursday                                                                                                 
1 Monday                                                                                                   
1 Monday                                                                                                   
2 Tuesday                                                                                                  
2 Thursday                                                                                                 
2 Tuesday                                                                                                  
3 Friday                                                                                                   
3 Sunday                                                                                                   
3 Friday                                                                                                   
3 Sunday                                                                                                   
3 Friday                                                                                                   
3 Sunday                                                                                                   
                                                                                                           
;;;;                                                                                                       
RUN;quit;                                                                                                  
                                                                                                           
                                                                                                           
WORK.HAVE total obs=12                                                                                     
                                                                                                           
                 | RULES                                                                                   
                 |                                                                                         
ID    WEEKDAY    |  ID  WEEKDAY  CNT                                                                       
                 |                                                                                         
 1    Thursday   |                                                                                         
 1    Monday     |                                                                                         
 1    Monday     |   1    Monday   2  (two Mondays)                                                        
                 |                                                                                         
 2    Tuesday    |                                                                                         
 2    Thursday   |                                                                                         
 2    Tuesday    |   2    Tuesday  2                                                                       
                 |                                                                                         
 3    Friday     |                                                                                         
 3    Sunday     |                                                                                         
 3    Friday     |                                                                                         
 3    Sunday     |   3    Friday   3                                                                       
 3    Friday     |   3    Sunday   3                                                                       
 3    Sunday     |                                                                                         
                                                                                                           
                                                                                                           
*                                                                                                          
 ###   #   #  #####  ####   #   #  #####                                                                   
#   #  #   #    #    #   #  #   #    #                                                                     
#   #  #   #    #    #   #  #   #    #                                                                     
#   #  #   #    #    ####   #   #    #                                                                     
#   #  #   #    #    #      #   #    #                                                                     
#   #  #   #    #    #      #   #    #                                                                     
 ###    ###     #    #       ###     #                                                                     
                                                                                                           
#! OUTPUT ;                                                                                                
                                                                                                           
                                                                                                           
WORK.WANT total obs=4                                                                                      
                                                                                                           
  ID    WEEKDAY    CNT                                                                                     
                                                                                                           
   1    Monday      2                                                                                      
   2    Tuesday     2                                                                                      
   3    Friday      3                                                                                      
   3    Sunday      3                                                                                      
                                                                                                           
*                                                                                                          
####   ####    ###    ###   #####   ###    ###                                                             
#   #  #   #  #   #  #   #  #      #   #  #   #                                                            
#   #  #   #  #   #  #      #       #      #                                                               
####   ####   #   #  #      ####     #      #                                                              
#      # #    #   #  #      #         #      #                                                             
#      #  #   #   #  #   #  #      #   #  #   #                                                            
#      #   #   ###    ###   #####   ###    ###                                                             
                                                                                                           
#! PROCESS ;                                                                                               
                                                                                                           
proc sql;                                                                                                  
                                                                                                           
  create                                                                                                   
    table want as                                                                                          
                                                                                                           
  select                                                                                                   
    id                                                                                                     
    ,weekday                                                                                               
    ,cnt                                                                                                   
  from (                                                                                                   
        select                                                                                             
           id                                                                                              
          ,weekday                                                                                         
          ,count(weekday) as cnt                                                                           
        from                                                                                               
           have                                                                                            
        group                                                                                              
           by id, weekday                                                                                  
        )                                                                                                  
   group                                                                                                   
        by id                                                                                              
   having                                                                                                  
        cnt = max(cnt)                                                                                     
;quit;                                                                                                     
                                                                                                           
                                                                                                           
