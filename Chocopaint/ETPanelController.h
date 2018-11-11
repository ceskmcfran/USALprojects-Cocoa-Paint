//
//  ETPanelController.h
//  Chocopaint
//
//  Created by ceskmcfran on 12/12/2016.
//  Copyright © 2016 Francisco Blázquez. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class Figura;

@interface ETPanelController : NSWindowController <NSTableViewDelegate, NSTableViewDataSource>{
    
    NSMutableArray * arrayFiguras; //Modelo
    
    //Punteros a los elementos de la ventana auxiliar
    IBOutlet NSTextField * tbIdentificador;
    IBOutlet NSTextField * tbAlto;
    IBOutlet NSTextField * tbAncho;
    IBOutlet NSTextField * tbGrosor;
    IBOutlet NSTextField * tbX1, * tbY1;
    IBOutlet NSColorWell * cwBorde, * cwRelleno;
    IBOutlet NSComboBox * cbFigura;
    IBOutlet NSButton * bAnadir, * bEliminar, *bModificar;
    IBOutlet NSTableView * tvTabla;
    
}

- (void)windowDidLoad;
- (void)awakeFromNib; //Metodo una vez cargada la ventana
- (id) initWithArray:(NSMutableArray *)arrayFiguras; //Init

- (IBAction) buttonAnadirPushed:(id)sender; //Boton añadir
- (IBAction) buttonEliminarPushed:(id)sender; //Boton eliminar
- (IBAction) buttonModificarPushed:(id)sender; //Boton modificar

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView; //Devuelve el numero de filas a mostrar por la tabla
- (id)tableView:(NSTableView *)aTableView
objectValueForTableColumn:(NSTableColumn *)aTableColumn
            row:(NSInteger)rowIndex; //Devuelve el objeto a mostrar en la fila rowIndex de la columna aTableColumn
- (void)tableViewSelectionDidChange:(NSNotification *)aNotification; //Modifica los elementos del panel si se selecciona una figura del textView

- (void)handleActualizarTabla:(NSNotification *)aNotificacion; //Handler para actualizar la tabla


@end
