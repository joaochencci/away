//
//  Session.m
//  Away
//
//  Created by Wesley Ide on 31/01/14.
//  Copyright (c) 2014 Wesley Ide. All rights reserved.
//

#import "Session.h"

@implementation Session

@synthesize user;
@synthesize currentDestination;
@synthesize currentDestinationDetail;
@synthesize destinations;

@synthesize destinationsChoose;
@synthesize destinationsReject;
@synthesize currentLocation;
@synthesize locationManager;

#pragma mark Singleton Methods

+ (id)sharedSession {
    static Session *sharedSession = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSession = [[self alloc] init];
    });
    return sharedSession;
}

- (id)init {
    if (self = [super init]) {
        destination = [[Destination alloc] init];
        destinations = [[NSMutableArray alloc] init];
        destinationsChoose = [[NSMutableArray alloc] init];
        destinationsReject = [[NSMutableArray alloc] init];

        currentLocation = [[CLLocation alloc] init];
        locationManager = [[CLLocationManager alloc] init];
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        locationManager.delegate = self;
        [locationManager startUpdatingLocation];

        [self populateDestinations];
    }
    return self;
}

- (void)populateDestinations {
    [destinations addObject:[self addDestinationWithName:@"Belo Horizonte"
                                             description:@"Belo Horizonte é um município brasileiro, capital do estado de Minas Gerais. Pertence à Mesorregião Metropolitana de Belo Horizonte e à Microrregião de Belo Horizonte. Com uma área de aproximadamente 330 km², possui uma geografia diversificada, com morros e baixadas, distando 716 quilômetros de Brasília, a capital nacional."
                                                distance:574
                                          viewPointsName:@[@"Estádio Mineirão",@"Pq. Ecológico da Pampulha",@"Praça da Liberdade",@"Gruta da Lapinha"]
                                   andViewPointsImageUrl:@[@"https://i.imgur.com/St5x1Az.jpg",@"https://i.imgur.com/HCicHCK.jpg",@"https://i.imgur.com/Rjhnrj9.jpg",@"https://i.imgur.com/PK0cJLC.jpg"]
                             ]];

    [destinations addObject:[self addDestinationWithName:@"Brasília"
                                             description:@"Brasília é a capital federal do Brasil e a sede do governo do Distrito Federal.9 10 A cidade está localizada na região Centro-Oeste do país, ao longo da região geográfica conhecida como Planalto Central. No censo demográfico realizado pelo Instituto Brasileiro de Geografia e Estatística em 2010, sua população era de 2.562.963 habitantes (3.716.996 em sua área metropolitana), sendo, então, a quarta cidade brasileira mais populosa.A capital brasileira é a maior cidade do mundo construída no século XX."
                                                distance:909
                                          viewPointsName:@[@"Pontão do Lago Sul",@"Ponte J. Kubitschek",@"Congresso Nacional",@"Estádio Mané Garrincha"]
                                   andViewPointsImageUrl:@[@"https://i.imgur.com/UKFBAO8.jpg",@"https://i.imgur.com/H61XkiU.jpg",@"https://i.imgur.com/Lj3K9We.jpg",@"https://i.imgur.com/L4TI6IA.jpg"]
                             ]];

    [destinations addObject:[self addDestinationWithName:@"Cuiabá"
                                             description:@"Cuiabá é a capital e maior cidade do estado de Mato Grosso. O município está situado na margem esquerda do rio de mesmo nome e forma uma conurbação com o município vizinho, Várzea Grande. Segundo estimativas de 2013 feitas pelo IBGE, a população de Cuiabá é de 569.830 habitantes, enquanto que a população da conurbação se aproxima de 820.000; já sua região metropolitana possui 863.509 habitantes e o colar metropolitano quase 1 milhão; sua mesorregião possui 1.100.512 habitantes, o que faz de Cuiabá uma pequena metrópole no centro da América do Sul. A cidade é umas das 12 sedes da Copa do mundo FIFA de 2014, representando o Pantanal (a cidade se situa a cerca de 100 quilômetros da região pantaneira)."
                                                distance:1512
                                          viewPointsName:@[@"Centro Histórico",@"Arena Pantanal",@"Parque Massairo Okamura"]
                                   andViewPointsImageUrl:@[@"https://i.imgur.com/TsS3G28.jpg",@"https://i.imgur.com/1zdHHht.jpg",@"https://i.imgur.com/gJmHDZz.jpg"]
                             ]];

    [destinations addObject:[self addDestinationWithName:@"Curitiba"
                                             description:@"Curitiba é um município brasileiro, capital do estado do Paraná, localizada a 934 metros de altitude no primeiro planalto paranaense,7 a aproximadamente 110 quilômetros do Oceano Atlântico.11 É a oitava cidade mais populosa do Brasil e a maior do sul do país, com uma população de 1.848.943 habitantes.6 É a cidade principal da Região Metropolitana de Curitiba, formada por 29 municípios e que possui 3.400.357 habitantes sobre uma área de 15.447 km², o que a torna a oitava região metropolitana mais populosa do Brasil, e a segunda maior da Região Sul, ficando somente atrás da Região Metropolitana de Porto Alegre. A capital do Paraná ao longo dos últimos anos tem se consolidado como a cidade mais rica do Sul do país e a 4ª em nível nacional."
                                                distance:497
                                          viewPointsName:@[@"Arena da Baixada",@"Cataratas do Iguaçu",@"Bosque Alemão",@"Jardim Botânico de Curitiba"]
                                   andViewPointsImageUrl:@[@"https://i.imgur.com/7je6Rnr.jpg",@"https://i.imgur.com/AzOirqE.jpg",@"https://i.imgur.com/MvywTqn.jpg",@"https://i.imgur.com/J5UovPl.jpg"]
                             ]];

    [destinations addObject:[self addDestinationWithName:@"Fortaleza"
                                             description:@"Fortaleza é um município brasileiro, capital do estado do Ceará. Pertence à mesorregião Metropolitana de Fortaleza e à microrregião de Fortaleza. A cidade desenvolveu-se às margens do riacho Pajeú, no nordeste do país, a 2.285 quilômetros de Brasília. Sua toponímia é uma alusão ao Forte Schoonenborch, construído pelos holandeses durante sua segunda permanência no local entre 1649 e 1654. O lema da cidade (presente em seu brasão) é a palavra em latim \"Fortitudine\", que em português significa: \"força, valor, coragem\"."
                                                distance:2834
                                          viewPointsName:@[@"Praia das Fontes",@"Feira Beira Mar",@"Estádio Castelão",@"Praia do Futuro"]
                                   andViewPointsImageUrl:@[@"https://i.imgur.com/Bd6JUBR.jpg",@"https://i.imgur.com/iVWeyuV.jpg",@"https://i.imgur.com/e4yN0gt.jpg",@"https://i.imgur.com/f6Px5tN.jpg"]
                             ]];

}

- (Destination*)addDestinationWithName:(NSString*)name description:(NSString*)description distance:(int)distance viewPointsName:(NSArray*)viewPointsName andViewPointsImageUrl:(NSArray*)viewPointsImageUrl
{
    Destination *dest = [[Destination alloc] init];
    dest.title = name;
    dest.description = description;
//    dest. = basePrice;

    for (int i = 0 ; i < [viewPointsName count]; i++) {
        DestinationViewPoint *vp = [[DestinationViewPoint alloc] init];
        vp.name = viewPointsName[i];
        vp.distance = distance;
        vp.imageUrl = viewPointsImageUrl[i];
        [dest.viewPoints addObject:vp];
    }
    return dest;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    //if the time interval returned from core location is more than two minutes we ignore it because it might be from an old session
//    if ( abs((int) [newLocation.timestamp timeIntervalSinceDate: [NSDate date]]) < 120) {
        self.currentLocation = newLocation;
//    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    //    [[[UIAlertView alloc] initWithTitle:@"Error" message:[error description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

- (BOOL)isDestination: (Destination*)dest in: (NSMutableArray*)dests {
    for (Destination *d in dests) {
        if ([d._id isEqualToString:dest._id]){
            return TRUE;
        }
    }
    return FALSE;
}

- (void)removeDestinationAtIndex:(NSInteger)index
{
    if (index >= 0 && index < [self.destinationsChoose count]){
        [self.destinationsChoose removeObjectAtIndex:index];
    }
}

///* - (BOOL) containsUserInSession:(User*)user
//    Verifica se determinado usuário está na sessão.
// */
//- (BOOL) containsUserInSession:(User*)user {
//    for (User *u in usersSession) {
//        if ([u.mail isEqualToString:user.mail] &&
//            [u.password isEqualToString:user.password]){
//            return TRUE;
//        }
//    }
//    return FALSE;
//}
//
///* - (BOOL) containsUserRegistred:(User*)user
//    Verifica se determinado usuário está cadastrado.
// */
//- (BOOL) containsUserRegistred:(User*)user {
//    for (User *u in usersRegistred) {
//        if ([u.mail isEqualToString:user.mail] &&
//            [u.password isEqualToString:user.password]){
//            return TRUE;
//        }
//    }
//    return FALSE;
//}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
