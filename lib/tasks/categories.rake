namespace :categories do
  desc "Create default categories"
  task create: :environment do

    cat1 = Category.create name_es: "COMIDAS & BEBIDAS", name_en: "FOOD & DRINKS", category_type: 1, icon: "chevron-circle-right"

      cat1_subcat1 = Category.create name_es:"Cena", name_en: "Dining", category_type: 2, parent_id: cat1.id, icon: "dot-circle-o"
        Category.create name_es:"Americana y Continental", name_en: "American and Continental", category_type: 3, parent_id: cat1_subcat1.id
        Category.create name_es:"Asiática", name_en: "Asian", category_type: 3, parent_id: cat1_subcat1.id
        Category.create name_es:"Sandwiches & Panecillos", name_en: "Deli & Bagel", category_type: 3, parent_id: cat1_subcat1.id
        Category.create name_es:"Italiana", name_en: "Italian", category_type: 3, parent_id: cat1_subcat1.id
        Category.create name_es:"Comida de la India", name_en: "Indian", category_type: 3, parent_id: cat1_subcat1.id
        Category.create name_es:"Internacional", name_en: "International", category_type: 3, parent_id: cat1_subcat1.id
        Category.create name_es:"Mexicana", name_en: "Mexican", category_type: 3, parent_id: cat1_subcat1.id
        Category.create name_es:"Marina", name_en: "Seafood", category_type: 3, parent_id: cat1_subcat1.id
        Category.create name_es:"Española", name_en: "Spanish", category_type: 3, parent_id: cat1_subcat1.id
        Category.create name_es:"Especialidades", name_en: "Specialty", category_type: 3, parent_id: cat1_subcat1.id
        Category.create name_es:"Carne Asada", name_en: "Steak Houses", category_type: 3, parent_id: cat1_subcat1.id
        Category.create name_es:"Comida Rapida", name_en: "Fast Food", category_type: 3, parent_id: cat1_subcat1.id
        Category.create name_es:"Comida a Domicilio", name_en: "Pick up & Delivery", category_type: 3, parent_id: cat1_subcat1.id
        Category.create name_es:"Comida para Eventos en Casa o Oficina", name_en: "Catering", category_type: 3, parent_id: cat1_subcat1.id

      cat1_subcat2 = Category.create name_es:"Bebidas", name_en: "Drinks", category_type: 2, parent_id: cat1.id, icon: "dot-circle-o"
        Category.create name_es:"Cafeterias", name_en: "Coffee Shops", category_type: 3, parent_id: cat1_subcat2.id
        Category.create name_es:"Cervezas y vinos", name_en: "Beer and Wine", category_type: 3, parent_id: cat1_subcat2.id
        Category.create name_es:"Bar Completo", name_en: "Full Bar", category_type: 3, parent_id: cat1_subcat2.id
        Category.create name_es:"Yogourt & Jugos Naturales", name_en: "Yogourt & Juices", category_type: 3, parent_id: cat1_subcat2.id

    cat2 = Category.create name_es: "COMPRAS", name_en: "SHOPPING", category_type: 1, icon: "chevron-circle-right"
      Category.create name_es:"supermercados", name_en: "Supermarket", category_type: 2, parent_id: cat2.id, icon: "dot-circle-o"
      Category.create name_es:"Ciclismo", name_en: "Bicycling", category_type: 2, parent_id: cat2.id, icon: "dot-circle-o"
      Category.create name_es:"Automobiles y Motocicletas", name_en: "Automobiles and Motorcycles", category_type: 2, parent_id: cat2.id, icon: "dot-circle-o"
      Category.create name_es:"Vestuario, Zapatos y Accesorios para Ropa", name_en: "Apparel, Footware & Accessories", category_type: 2, parent_id: cat2.id, icon: "dot-circle-o"
      Category.create name_es:"Licoreras", name_en: "Liquor Stores", category_type: 2, parent_id: cat2.id, icon: "dot-circle-o"
      Category.create name_es:"Carnicerías", name_en: "Meat Shops", category_type: 2, parent_id: cat2.id, icon: "dot-circle-o"
      Category.create name_es:"Electrónica , Teléfonos & Computadoras", name_en: "Electronics, Phones and Computers", category_type: 2, parent_id: cat2.id, icon: "dot-circle-o"
      Category.create name_es:"Telefonia, TV Cable & Internet", name_en: "Phone, Cable & Internet", category_type: 2, parent_id: cat2.id, icon: "dot-circle-o"
      Category.create name_es:"Seguridad para el hogar", name_en: "Home Security", category_type: 2, parent_id: cat2.id, icon: "dot-circle-o"
      Category.create name_es:"Productos para el Hogar y Ferreterías", name_en: "Home & Hardware Stores", category_type: 2, parent_id: cat2.id, icon: "dot-circle-o"
      Category.create name_es:"Productos para Oficinas", name_en: "Office Supplies", category_type: 2, parent_id: cat2.id, icon: "dot-circle-o"
      Category.create name_es:"Productos para Piscinas", name_en: "Pool Supplies", category_type: 2, parent_id: cat2.id, icon: "dot-circle-o"
      Category.create name_es:"Joyerías & Relojerías", name_en: "Jewelry & Watches", category_type: 2, parent_id: cat2.id, icon: "dot-circle-o"
      Category.create name_es:"Tiendas de Especialidades y Manualidades", name_en: "Specialties Stores", category_type: 2, parent_id: cat2.id, icon: "dot-circle-o"
      Category.create name_es:"Centros de Reparación", name_en: "Repair Centers", category_type: 2, parent_id: cat2.id, icon: "dot-circle-o"

    cat3 = Category.create name_es: "SERVICIOS PERSONALES", name_en: "PERSONAL SERVICES", category_type: 1, icon: "chevron-circle-right"
      Category.create name_es:"Salones, Spas y Barberías", name_en: "Full Service Salon, Spas and Barber Shops", category_type: 2, parent_id: cat3.id, icon: "dot-circle-o"
      Category.create name_es:"Tintorerías, Lavanderías & Sastrerías", name_en: "Dry Cleaning & Laundry and Alterations", category_type: 2, parent_id: cat3.id, icon: "dot-circle-o"
      Category.create name_es:"Centros Postales, Servicios de Impresión, Couriers", name_en: "Postal Centers, Printing & Express Mailing", category_type: 2, parent_id: cat3.id, icon: "dot-circle-o"
      Category.create name_es:"Gimnasios, Estudios y Acondicionamiento Físico", name_en: "Fitness Clubs, Studios and Gyms", category_type: 2, parent_id: cat3.id, icon: "dot-circle-o"
      Category.create name_es:"Centros de Reducción de Peso", name_en: "Weight Loss Centers", category_type: 2, parent_id: cat3.id, icon: "dot-circle-o"
      Category.create name_es:"Servicio Para Automobiles", name_en: "Automotive Services", category_type: 2, parent_id: cat3.id, icon: "dot-circle-o"
      Category.create name_es:"Agencias de Viajes", name_en: "Travel Agency", category_type: 2, parent_id: cat3.id, icon: "dot-circle-o"
      Category.create name_es:"Servicios Para Perros y Gatos", name_en: "Dog & Cat Grooming", category_type: 2, parent_id: cat3.id, icon: "dot-circle-o"
      Category.create name_es:"Floristerías & Regalos", name_en: "Florists & Gifts", category_type: 2, parent_id: cat3.id, icon: "dot-circle-o"
      Category.create name_es:"Tutores y Clases Especialidades", name_en: "Tutoring and Classes", category_type: 2, parent_id: cat3.id, icon: "dot-circle-o"

    cat4 = Category.create name_es: "SERVICIOS PROFESIONALES", name_en: "PROFESSIONAL SERVICES", category_type: 1, icon: "chevron-circle-right"
      Category.create name_es:"Dentistas", name_en: "Dentistry", category_type: 2, parent_id: cat4.id, icon: "dot-circle-o"
      Category.create name_es:"Cuidado Para La Salud", name_en: "Health Care", category_type: 2, parent_id: cat4.id, icon: "dot-circle-o"
      Category.create name_es:"Veterinarias", name_en: "Veterinarians", category_type: 2, parent_id: cat4.id, icon: "dot-circle-o"
      Category.create name_es:"Servicios de Jardinería", name_en: "Landscape", category_type: 2, parent_id: cat4.id, icon: "dot-circle-o"
      Category.create name_es:"Contratistas, Reparaciones y Mantenimiento para el Hogar", name_en: "House Services", category_type: 2, parent_id: cat4.id, icon: "dot-circle-o"
      Category.create name_es:"Servicios Legales", name_en: "Law Offices", category_type: 2, parent_id: cat4.id, icon: "dot-circle-o"
      Category.create name_es:"Oficinas de Seguros", name_en: "Insurance Offices", category_type: 2, parent_id: cat4.id, icon: "dot-circle-o"
      Category.create name_es:"Contabilidad e Impuestos", name_en: "Accounting and Taxes", category_type: 2, parent_id: cat4.id, icon: "dot-circle-o"
      Category.create name_es:"Alquileres para Fiestas y Entretenimiento", name_en: "Party Places, Rentals & Entertainers", category_type: 2, parent_id: cat4.id, icon: "dot-circle-o"
      Category.create name_es:"Servicios Especializados", name_en: "Specialty Services", category_type: 2, parent_id: cat4.id, icon: "dot-circle-o"
      Category.create name_es:"Colegios y Guarderias", name_en: "Schools & Day Care Centers", category_type: 2, parent_id: cat4.id, icon: "dot-circle-o"

    cat5 = Category.create name_es: "INMOBILIARIA", name_en: "REAL STATE", category_type: 1, icon: "chevron-circle-right"
      Category.create name_es:"Inmobiliarias y Corredores Inmobiliarios", name_en: "Agencies & Realtors", category_type: 2, parent_id: cat5.id, icon: "dot-circle-o"
      Category.create name_es:"Renta de Inmuebles", name_en: "Renting", category_type: 2, parent_id: cat5.id, icon: "dot-circle-o"
      Category.create name_es:"Venta de Inmuebles", name_en: "Selling", category_type: 2, parent_id: cat5.id, icon: "dot-circle-o"

    cat6 = Category.create name_es: "HOTELES & ALOJAMIENTO", name_en: "LODGING", category_type: 1, icon: "chevron-circle-right"
      Category.create name_es:"Hoteles", name_en: "Hoteles", category_type: 2, parent_id: cat6.id, icon: "dot-circle-o"
      Category.create name_es:"Moteles", name_en: "Moteles", category_type: 2, parent_id: cat6.id, icon: "dot-circle-o"
      Category.create name_es:"Alquileres Vacacionales", name_en: "Vacation Rentals", category_type: 2, parent_id: cat6.id, icon: "dot-circle-o"
      Category.create name_es:"Tiempo Compartido", name_en: "Time Share", category_type: 2, parent_id: cat6.id, icon: "dot-circle-o"

    cat7 = Category.create name_es: "INSTITUCIONES FINANCIERAS", name_en: "FINANCIAL INSTITUTIONS", category_type: 1, icon: "chevron-circle-right"
      Category.create name_es:"Bancos", name_en: "Banks", category_type: 2, parent_id: cat7.id, icon: "dot-circle-o"
      Category.create name_es:"Servicios Financieros", name_en: "Financial Services", category_type: 2, parent_id: cat7.id, icon: "dot-circle-o"
      Category.create name_es:"Cooperativas de Credito", name_en: "Credit Unions", category_type: 2, parent_id: cat7.id, icon: "dot-circle-o"

    cat8 = Category.create name_es: "PARQUES & RECREACIONES", name_en: "PARKS & RECREATION", category_type: 1, icon: "chevron-circle-right"
      Category.create name_es:"Parques Públicos", name_en: "Public Parks", category_type: 2, parent_id: cat8.id, icon: "dot-circle-o"
      Category.create name_es:"Parques para Mascotas", name_en: "Animal Parks", category_type: 2, parent_id: cat8.id, icon: "dot-circle-o"
      Category.create name_es:"Zoológicos", name_en: "Zoo", category_type: 2, parent_id: cat8.id, icon: "dot-circle-o"
      Category.create name_es:"Parques Acuáticos", name_en: "Water Parks", category_type: 2, parent_id: cat8.id, icon: "dot-circle-o"
      Category.create name_es:"Parques Temáticos", name_en: "Themed Parks", category_type: 2, parent_id: cat8.id, icon: "dot-circle-o"

    cat9 = Category.create name_es: "EVENTOS EN MI CIUDAD", name_en: "CITY EVENTS", category_type: 1, icon: "chevron-circle-right"
      Category.create name_es:"Eventos Comunitarios", name_en: "Community Events", category_type: 2, parent_id: cat9.id, icon: "dot-circle-o"
      Category.create name_es:"Conciertos de Musicales", name_en: "Music Concerts", category_type: 2, parent_id: cat9.id, icon: "dot-circle-o"
      Category.create name_es:"Eventos Deportivos", name_en: "Sports Events", category_type: 2, parent_id: cat9.id, icon: "dot-circle-o"
      Category.create name_es:"Eventos Corporativos", name_en: "Corporate Events", category_type: 2, parent_id: cat9.id, icon: "dot-circle-o"

    cat10 = Category.create name_es: "CARIDADES", name_en: "CHARITY", category_type: 1, icon: "chevron-circle-right"
      Category.create name_es:"Eventos de Caridad", name_en: "Charity Events", category_type: 2, parent_id: cat10.id, icon: "dot-circle-o"
      Category.create name_es:"Donaciones y Servicios para Recoger Donaciones", name_en: "Donations and Donations pick up", category_type: 2, parent_id: cat10.id, icon: "dot-circle-o"
      Category.create name_es:"Patrocinios y Oportunidades", name_en: "Sponsorships and Opportunities", category_type: 2, parent_id: cat10.id, icon: "dot-circle-o"

  end
end
