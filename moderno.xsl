<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <head>
                <title>Modelo Factura Óscar</title>
                <style>
    body { 
        font-family: 'Inter', sans-serif; 
        background-color: #eef5ff; 
        margin: 0; 
        padding: 20px; 
        display: flex; 
        justify-content: center;
    }
    .invoice-container { 
        max-width: 700px; 
        background: #ffffff; 
        border-radius: 10px; 
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15); 
        padding: 20px; 
        border-top: 6px solid #007bff; /* Color azul vibrante */
    }
    .header { 
        text-align: center; 
        font-size: 24px; 
        font-weight: bold; 
        padding-bottom: 10px; 
        border-bottom: 3px solid #007bff; 
        color: #007bff;
    }
    .header__section{
        display : flex;
        justify-content: space-between;

    }
    .section__title{
        texalign: center;
        text-transform: uppercase;
        text-decoration: underline;
    }
    .section { 
        padding: 12px; 
        font-size: 15px; 
        color: #333; 
        background: #f8f9fa; 
        border-radius: 5px; 
        margin-bottom: 10px; 
    }
    .table { 
        width: 100%; 
        border-collapse: collapse; 
        font-size: 14px; 
    }
    .table th { 
        background: #007bff; 
        color: #ffffff; 
        font-weight: 600; 
        padding: 10px;
    }
    .table td { 
        padding: 10px; 
        text-align: left; 
        border-bottom: 1px solid #ddd; 
    }
    .table tr:nth-child(even) { 
        background: #f1f8ff; /* Color claro para filas alternas */
    }
    .total { 
        font-size: 16px; 
        font-weight: bold; 
        text-align: right; 
        margin-top: 15px; 
        color: #007bff; 
        padding-left: 10px;
    }
    .button { 
        display: block; 
        width: 100%; 
        text-align: center; 
        background: #007bff; 
        color: #fff; 
        padding: 12px; 
        border-radius: 5px; 
        text-decoration: none; 
        font-weight: bold; 
        margin-top: 20px;
        transition: background 0.3s ease;
    }
    .button:hover { 
        background: #0056b3; 
    }
    .cif{
        text-align: center;
    }
</style>

    
            </head>
            <body>
                <div class="invoice-container">
                    
                    <div class="header">
                    <img src="https://oscarsalazar.es/assets/logo/logoperfectobicolor.svg" alt="Logo del oscar" width="30px"/>
                    Modelo Factura Óscar</div>
                    
                    <header class="header__section">
                    <!-- Datos del vendedor -->
                    <div class="section">
                        <h2 class="section__title">Vendedor</h2>
                        <h3><strong> <xsl:value-of select="//SellerParty/LegalEntity/CorporateName"/></strong></h3>
                        <p><strong>Dirección: </strong> <xsl:value-of select="//SellerParty/LegalEntity/AddressInSpain/Address"/></p>
                        <p><strong>CP: </strong> <xsl:value-of select="//SellerParty/LegalEntity/AddressInSpain/PostCode"/></p>
                        <p class="cif"><strong>CIF: </strong> <xsl:value-of select="//SellerParty/TaxIdentification/TaxIdentificationNumber"/></p>
                    </div>
                    
                    <!-- Datos del comprador -->
                    <div class="section">
                        <h2 class="section__title">Comprador</h2>
                        <h3><strong> <xsl:value-of select="concat(//BuyerParty/Individual/Name, ' ', //BuyerParty/Individual/FirstSurname)" /></strong></h3>
                        <p><strong>Dirección:</strong> <xsl:value-of select="//*[local-name()='BuyerParty']/*[local-name()='Individual']/*[local-name()='OverseasAddress']/*[local-name()='Address']"/></p>
                        <p><strong>CP: </strong> <xsl:value-of select="//BuyerParty/Individual/OverseasAddress/PostCodeAndTown"/></p>
                        <p class="cif"><strong>CIF: </strong> <xsl:value-of select="//BuyerParty/TaxIdentification/TaxIdentificationNumber"/></p>
                    </div>
                    
                    </header>
                    <!-- Detalles de la factura -->
                    <div class="section">
                        <h2>Detalles de la Factura</h2>
                        <p><strong>Número: </strong> <xsl:value-of select="//*[local-name()='Invoice']/*[local-name()='InvoiceHeader']/*[local-name()='InvoiceNumber']"/></p>
                        <p><strong>Fecha: </strong> <xsl:value-of select="//*[local-name()='Invoice']/*[local-name()='InvoiceIssueData']/*[local-name()='IssueDate']"/></p>
                        <table class="table">
                            <tr>
                                <th>Descripción</th>
                                <th>Cantidad</th>
                                <th>Precio Unitario</th>
                                <th>Descuento</th>
                                <th>Cargo</th>
                                <th>Total</th>
                            </tr>
                            <xsl:for-each select="//*[local-name()='InvoiceLine']">
                                <tr>
                                    <td><xsl:value-of select="ItemDescription"/></td>
                                    <td><xsl:value-of select="Quantity"/></td>
                                    <td><xsl:value-of select="UnitPriceWithoutTax"/></td>
                                    <td><xsl:value-of select="DiscountsAndRebates/Discount/DiscountAmount"/></td>
                                    <td><xsl:value-of select="Charges/Charge/ChargeAmount"/></td>
                                    <td><xsl:value-of select="GrossAmount"/></td>
                                </tr>
                            </xsl:for-each>
                        </table>
                        <div class="total">
                            <p><strong>Total Factura: </strong> <xsl:value-of select="//InvoiceTotals/TotalGrossAmount"/> €</p>
                            <p><strong>Impuestos: </strong> <xsl:value-of select="//InvoiceTotals/TotalTaxOutputs"/> €</p>
                            <p><strong>Total Factura: </strong> <xsl:value-of select="//InvoiceTotals/InvoiceTotal"/> €</p>                                                    
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
