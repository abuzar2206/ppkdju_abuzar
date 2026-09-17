import 'package:flutter/material.dart';
// Mengambil library Flutter untuk membuat tampilan aplikasi.

class Store extends StatelessWidget { 
  const Store({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    return Scaffold( 
      appBar: AppBar(
        title: Text(        
          'Detail Toko',
          style: TextStyle(           
            color: const Color.fromARGB(255, 0, 0, 0),           
            fontSize: 20,           
            fontWeight: FontWeight.bold,          
          ),
        ),

        centerTitle: true,       
        backgroundColor: Color.fromARGB(255, 28, 175, 204),       
        elevation: 0,      
      ),
    
      backgroundColor: Color.fromARGB(255, 225, 225, 233),
      body: Column(
        children: [
          Padding(           
            padding: EdgeInsets.all(20),
            child: Text(             
              'Harmony Mystic Emporium',
              textAlign: TextAlign.center,             
              style: TextStyle(
                fontSize: 20,               
                fontStyle: FontStyle.italic,             
              ),
            ),
          ),


          Container(          
            margin: EdgeInsets.symmetric(horizontal: 15),
            padding: EdgeInsets.all(10),          
            width: double.infinity,
            decoration: BoxDecoration(             
              color: Color.fromARGB(255, 70, 185, 206),
            borderRadius: BorderRadius.circular(30),
               ),

            child: Row(            
              children: [
                Icon(
                  Icons.email,                
                  color: const Color.fromARGB(255, 0, 0, 0),                  
                ),
                SizedBox(width: 10),
                Text(
                  'abuzaraboyy@gmail.com',

                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,                   
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [              

                Row(
                  children: [
                    Icon(Icons.phone),                  
                    SizedBox(width: 10),                    
                    Text('081284057625'),            
                  ],
                ),

                Row(
                  children: [
                    Icon(Icons.location_on),                  
                    SizedBox(width: 10),                 
                    Text('Jakarta, Indonesia'),
                   
                  ],
                ),
              ],
            ),
          ),


          Row(           
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,           
            children: [              
              Container(
                width: 150,               
                padding: EdgeInsets.all(10),               
                decoration: BoxDecoration(
                  color: Color.fromRGBO(100, 192, 245, 1),                 
                  borderRadius: BorderRadius.circular(10),                 
                ),

                child: Column(                 
                  children: [
                    Text(
                      '300+',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,                       
                        fontSize: 16,                     
                      ),
                    ),

                    Text(
                      'books sold per month',
                      style: TextStyle(
                        fontSize: 12,                       
                      ),
                    ),
                  ],
                ),
              ),              

              Container(
                width: 150,               
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:    Color.fromARGB(255, 77, 177, 243),                
                  borderRadius: BorderRadius.circular(10),                 
                ),

                child: Column(
                  children: [
                    Text(
                      '4.8/5 ⭐',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,                       
                        fontSize: 16,                      
                      ),
                    ),

                    Text(
                      'rating by user',

                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
         
          SizedBox(height: 25),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Harmony Mystic Emporium adalah toko buku bernuansa magis '
              'yang menghadirkan berbagai koleksi buku seperti novel fantasi, '
              'misteri, mitologi, spiritualitas, dan literatur klasik. '
              'Tempat ini dirancang dengan suasana hangat dan estetik '
              'sehingga nyaman untuk membaca dan menemukan cerita baru. ✨',

              textAlign: TextAlign.justify,             
              style: TextStyle(
                fontSize: 16,               
                height: 1.5,               
              ),
            ),
          ),

          SizedBox(height: 50),
          Container(          
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 200,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),            
              child: Image.asset(
                'assets/images/harmony.webp',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),         

          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}