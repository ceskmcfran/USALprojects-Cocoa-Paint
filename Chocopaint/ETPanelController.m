//
//  ETPanelController.m
//  Chocopaint
//
//  Created by ceskmcfran on 12/12/2016.
//  Copyright © 2016 Francisco Blázquez. All rights reserved.
//

#import "ETPanelController.h"
#import "Figura.h"

NSString * ETPanelDibujaFiguraNotification = @"ETPanelDibujaFigura";
extern NSString * LienzoNotificacion;

@interface ETPanelController ()

@end

@implementation ETPanelController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

//Init
-(id) initWithArray:(NSMutableArray *)aArrayFiguras
{
    if (![super initWithWindowNibName:@"ETPanelController"])
        return nil;
    
    arrayFiguras = aArrayFiguras;
    
    //Se recoge la notificacion para dibujar
    NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self
           selector:@selector(handleActualizarTabla:)
               name:LienzoNotificacion
             object:nil];
    
    return self;
}

//Metodo una vez cargada la ventana
-(void)awakeFromNib{
    
    //Selecciona por defecto el indice 0
    [cbFigura selectItemAtIndex:0];
    
}


//Handler que actualiza la tabla
- (void)handleActualizarTabla:(NSNotification *)aNotificacion{
    
    [tvTabla reloadData];
    
}


-(NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView{

    return [arrayFiguras count];
    
}

//Modifica los elementos del panel si se selecciona una figura del textView
-(void)tableViewSelectionDidChange:(NSNotification *)aNotification{
    
    //Se guarda la figura de la fila seleccionada
    NSInteger indice = [tvTabla selectedRow];
    if(indice > -1){
        Figura * fig = [arrayFiguras objectAtIndex:indice];
    
        //Se coloca en el text box
        [tbIdentificador setStringValue:[fig nombre]];
        [tbAlto setStringValue:[[fig alto]stringValue]];
        [tbAncho setStringValue:[[fig ancho]stringValue]];
        [tbGrosor setStringValue:[[fig grosor]stringValue]];
        [tbX1 setStringValue:[NSString stringWithFormat:@"%.2f", [fig origen].x]];
        [tbY1 setStringValue:[NSString stringWithFormat:@"%.2f", [fig origen].y]];
        [cbFigura selectItemAtIndex:[[fig tipo]integerValue]];
        [cwBorde setColor:[fig borde]];
        [cwRelleno setColor:[fig relleno]];
    }
}

//Metodo para la tabla
- (id)tableView:(NSTableView *)aTableView
objectValueForTableColumn:(NSTableColumn *)aTableColumn
            row:(NSInteger)rowIndex{

    //Se saca la figura de la posicion rowIndex
    Figura * f = [arrayFiguras objectAtIndex:rowIndex];

    //Se saca el identificador de la columna
    if([[aTableColumn identifier] isEqualToString:@"ID"]){
        return [f nombre];
    }
    else if([[aTableColumn identifier] isEqualToString:@"Figura"]){
        switch ([[f tipo]integerValue]) {
            case 0:
                return @"Linea";
                break;
                
            case 1:
                return @"Rectangulo";
                break;
                
            case 2:
                return @"Elipse";
                break;
        }
    }
    else if([[aTableColumn identifier] isEqualToString:@"Origen"]){
        return [NSString stringWithFormat:@"(%.2f , %.2f)", [f origen].x, [f origen].y];
    }
    else if([[aTableColumn identifier] isEqualToString:@"Alto"]){
        return [[f alto]stringValue];
    }
    else if([[aTableColumn identifier] isEqualToString:@"Ancho"]){
        return [[f alto]stringValue];
    }
    
    return nil;
}

//Metodo del boton añadir
-(IBAction) buttonAnadirPushed:(id)sender{
    
    //Se recogen los valores de los elementos de la ventana auxiliar y se crea la figura
    NSString * nombre = [tbIdentificador stringValue];
    NSNumber * alto = @([[tbAlto stringValue] floatValue]);
    NSNumber * ancho = @([[tbAncho stringValue] floatValue]);
    NSNumber * grosor = @([[tbGrosor stringValue] integerValue]);
    NSPoint origen = NSMakePoint([[tbX1 stringValue] integerValue], [[tbY1 stringValue] integerValue]);
    NSColor * borde = [cwBorde color];
    NSColor * relleno = [cwRelleno color];
    NSNumber * tipo = @([cbFigura indexOfSelectedItem]);
    
    Figura * f = [[Figura alloc]initFromTable:nombre
                                         tipo:tipo
                                         alto:alto
                                        ancho:ancho
                                       grosor:grosor
                                       origen:origen
                                        borde:borde
                                      relleno:relleno];
    
    //Se manda la figura al centro de notificaciones
    NSDictionary * notificationInfo = [NSDictionary dictionaryWithObject:f
                                                                  forKey:@"añadirFigura"];
    
    NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:ETPanelDibujaFiguraNotification
                      object:self
                    userInfo:notificationInfo];
    
    
}

//Metodo del boton eliminar
-(IBAction) buttonEliminarPushed:(id)sender{
    
    //Se recoge el indice de la fila seleccionada en la tabla
    NSInteger indice = [tvTabla selectedRow];
    
    if(indice > -1){
        //Se manda la figura al centro de notificaciones
        NSDictionary * notificationInfo = [NSDictionary dictionaryWithObject:@(indice)
                                                                      forKey:@"eliminarFigura"];
    
        NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:ETPanelDibujaFiguraNotification
                          object:self
                        userInfo:notificationInfo];
    
    }
}



//Metodo del boton modificar
-(IBAction) buttonModificarPushed:(id)sender{
    
    //Se recoge el indice de la fila seleccionada en la tabla
    NSInteger indice = [tvTabla selectedRow];
    
    //Se rellena una figura con lo que hay en los elementos del panel
    NSString * nombre = [tbIdentificador stringValue];
    NSNumber * alto = @([[tbAlto stringValue] floatValue]);
    NSNumber * ancho = @([[tbAncho stringValue] floatValue]);
    NSNumber * grosor = @([[tbGrosor stringValue] integerValue]);
    NSPoint origen = NSMakePoint([[tbX1 stringValue] integerValue], [[tbY1 stringValue] integerValue]);
    NSColor * borde = [cwBorde color];
    NSColor * relleno = [cwRelleno color];
    NSNumber * tipo = @([cbFigura indexOfSelectedItem]);
    
    Figura * f = [[Figura alloc]initFromTable:nombre
                                         tipo:tipo
                                         alto:alto
                                        ancho:ancho
                                       grosor:grosor
                                       origen:origen
                                        borde:borde
                                      relleno:relleno];

    //Se manda la figura y el indice al centro de notificaciones
    NSDictionary * notificationInfo = [NSDictionary dictionaryWithObjectsAndKeys:@(indice), @"modificarFiguraIndex", f, @"modificarFiguraFigura", nil];
    
    NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:ETPanelDibujaFiguraNotification
                      object:self
                    userInfo:notificationInfo];
    
}


@end
