import os
import base64
import subprocess

assets_dir = '/home/antonio/Documentos/DAM/Diseno-de-Interfaces/actividad 2 tema 3/memoria_assets'

def img_to_b64(filename):
    path = os.path.join(assets_dir, filename)
    with open(path, 'rb') as f:
        data = base64.b64encode(f.read()).decode('utf-8')
    return f"data:image/png;base64,{data}"

img_dartdoc = img_to_b64('dart_doc_quantity_stepper.png')
img_coverage = img_to_b64('coverage_quantity_stepper.png')
img_golden = img_to_b64('golden_quantity_stepper_val5.png')
img_widgetbook = img_to_b64('widgetbook_catalog.png')
img_app_es = img_to_b64('app_screenshot_es.png')
img_app_en = img_to_b64('app_screenshot_en.png')
img_app_limit = img_to_b64('app_screenshot_limit_reached.png')

html_content = f"""<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="utf-8">
<title>Memoria de Prácticas - Actividad 2 Tema 3 - Antonio Cano Ruiz</title>
<style>
  @page {{
    size: A4;
    margin: 20mm 15mm 20mm 15mm;
    @bottom-center {{
      content: counter(page);
    }}
  }}

  body {{
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
    color: #1e293b;
    line-height: 1.6;
    margin: 0;
    padding: 0;
    font-size: 13.5px;
    background: #ffffff;
  }}

  /* Portada */
  .cover-page {{
    page-break-after: always;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    min-height: 85vh;
    text-align: center;
    padding: 40px 20px;
    box-sizing: border-box;
  }}

  .cover-badge {{
    background: #e0e7ff;
    color: #3730a3;
    padding: 8px 18px;
    border-radius: 20px;
    font-weight: 700;
    font-size: 14px;
    letter-spacing: 0.05em;
    text-transform: uppercase;
    margin-bottom: 24px;
    display: inline-block;
  }}

  .cover-title {{
    font-size: 32px;
    font-weight: 800;
    color: #0f172a;
    line-height: 1.25;
    margin: 0 0 16px 0;
  }}

  .cover-subtitle {{
    font-size: 18px;
    color: #475569;
    max-width: 650px;
    margin: 0 auto 40px auto;
    font-weight: 400;
  }}

  .cover-meta {{
    margin-top: 40px;
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    border-radius: 16px;
    padding: 24px 36px;
    text-align: left;
    display: inline-block;
    min-width: 380px;
  }}

  .cover-meta table {{
    width: 100%;
    border-collapse: collapse;
  }}

  .cover-meta td {{
    padding: 6px 12px;
    font-size: 14px;
  }}

  .cover-meta td.label {{
    color: #64748b;
    font-weight: 600;
    width: 140px;
  }}

  .cover-meta td.val {{
    color: #0f172a;
    font-weight: 700;
  }}

  /* Estilos de secciones */
  .page-break {{
    page-break-before: always;
  }}

  h1 {{
    font-size: 22px;
    font-weight: 800;
    color: #0f172a;
    border-bottom: 2.5px solid #2563eb;
    padding-bottom: 8px;
    margin-top: 36px;
    margin-bottom: 18px;
    page-break-after: avoid;
  }}

  h2 {{
    font-size: 16px;
    font-weight: 700;
    color: #1e3a8a;
    margin-top: 24px;
    margin-bottom: 10px;
    page-break-after: avoid;
  }}

  h3 {{
    font-size: 14px;
    font-weight: 700;
    color: #334155;
    margin-top: 18px;
    margin-bottom: 8px;
    page-break-after: avoid;
  }}

  p {{
    margin: 0 0 12px 0;
    text-align: justify;
  }}

  ul, ol {{
    margin: 0 0 14px 0;
    padding-left: 24px;
  }}

  li {{
    margin-bottom: 6px;
  }}

  /* Cajas de llamada */
  .callout {{
    padding: 14px 18px;
    border-radius: 10px;
    margin: 16px 0;
    font-size: 13px;
    page-break-inside: avoid;
  }}

  .callout-info {{
    background-color: #eff6ff;
    border-left: 4px solid #3b82f6;
    color: #1e40af;
  }}

  .callout-success {{
    background-color: #ecfdf5;
    border-left: 4px solid #10b981;
    color: #065f46;
  }}

  .callout-warning {{
    background-color: #fffbeb;
    border-left: 4px solid #f59e0b;
    color: #92400e;
  }}

  .callout-title {{
    font-weight: 700;
    margin-bottom: 6px;
    display: flex;
    align-items: center;
    gap: 6px;
  }}

  /* Bloques de código */
  pre {{
    background: #0f172a;
    color: #f8fafc;
    padding: 14px 16px;
    border-radius: 10px;
    font-family: "SFMono-Regular", Consolas, "Liberation Mono", Menlo, Courier, monospace;
    font-size: 11.5px;
    line-height: 1.45;
    overflow-x: auto;
    margin: 14px 0;
    page-break-inside: avoid;
  }}

  code {{
    font-family: "SFMono-Regular", Consolas, "Liberation Mono", Menlo, Courier, monospace;
    font-size: 12px;
    background: #f1f5f9;
    color: #0f172a;
    padding: 2px 5px;
    border-radius: 4px;
  }}

  pre code {{
    background: transparent;
    color: inherit;
    padding: 0;
  }}

  /* Tablas */
  table.data-table {{
    width: 100%;
    border-collapse: collapse;
    margin: 16px 0;
    font-size: 12.5px;
    page-break-inside: avoid;
  }}

  table.data-table th, table.data-table td {{
    border: 1px solid #e2e8f0;
    padding: 8px 12px;
    text-align: left;
  }}

  table.data-table th {{
    background: #f8fafc;
    color: #475569;
    font-weight: 700;
  }}

  table.data-table tr:nth-child(even) {{
    background: #fbfcfe;
  }}

  /* Contenedores de imágenes */
  .screenshot-container {{
    margin: 20px 0;
    text-align: center;
    page-break-inside: avoid;
  }}

  .screenshot-img {{
    max-width: 95%;
    border: 1px solid #cbd5e1;
    border-radius: 10px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.06);
    display: inline-block;
  }}

  .screenshot-caption {{
    font-size: 11.5px;
    color: #64748b;
    margin-top: 8px;
    font-weight: 600;
  }}

  .grid-2 {{
    display: flex;
    gap: 16px;
    justify-content: center;
    margin: 16px 0;
    page-break-inside: avoid;
  }}

  .grid-2 .screenshot-container {{
    flex: 1;
    margin: 0;
  }}

  .grid-2 .screenshot-img {{
    max-width: 100%;
    height: auto;
  }}

  /* Footer */
  .footer-note {{
    margin-top: 40px;
    padding-top: 14px;
    border-top: 1px solid #e2e8f0;
    font-size: 11px;
    color: #94a3b8;
    text-align: center;
  }}
</style>
</head>
<body>

<!-- PORTADA -->
<div class="cover-page">
  <div class="cover-badge">Desarrollo de Aplicaciones Multiplataforma</div>
  <div class="cover-title">DISEÑO DE INTERFACES<br><span style="color: #2563eb; font-size: 26px;">Actividad 2 - Tema 3</span></div>
  <div class="cover-subtitle">
    Creación, Validación, Pruebas Unitarias y Golden, Empaquetado en Catálogo (Widgetbook), Documentación y Despliegue de Componentes Reutilizables en Flutter
  </div>

  <div class="cover-meta">
    <table>
      <tr>
        <td class="label">Alumno:</td>
        <td class="val">Antonio Cano Ruiz</td>
      </tr>
      <tr>
        <td class="label">Módulo:</td>
        <td class="val">Diseño de Interfaces (DAM)</td>
      </tr>
      <tr>
        <td class="label">Fecha:</td>
        <td class="val">Octubre 2026</td>
      </tr>
      <tr>
        <td class="label">Repositorio Git:</td>
        <td class="val">git@github.com:antcanor/Diseno-de-Interfaces.git</td>
      </tr>
      <tr>
        <td class="label">Versión Paquete:</td>
        <td class="val">ui_kit_dam v1.1.0 (Etiqueta Git v1.1.0)</td>
      </tr>
    </table>
  </div>
</div>

<!-- ÍNDICE -->
<div class="page-break"></div>
<h1>Tabla de Contenidos</h1>
<ol style="font-size: 14px; line-height: 2; margin-top: 20px;">
  <li><strong>A1. Primer Componente y Catálogo</strong>
    <ul style="line-height: 1.6; margin-top: 4px;">
      <li>Estructura del widget <code>QuantityStepper</code></li>
      <li>Exportación en el kit de UI</li>
      <li>Integración en el catálogo Widgetbook ("Por defecto")</li>
      <li><strong>Respuesta Teórica:</strong> ¿Por qué <code>QuantityStepper</code> es StatefulWidget y <code>InfoBadge</code> no?</li>
    </ul>
  </li>
  <li><strong>A2. Propiedades, Valores por Defecto y Accesibilidad</strong>
    <ul style="line-height: 1.6; margin-top: 4px;">
      <li>Configuración de rangos (<code>min</code>, <code>max</code>, <code>step</code>, <code>initialValue</code>)</li>
      <li>Aserciones en desarrollo y protección release</li>
      <li>Desactivación reactiva de controles</li>
      <li>Propiedades de accesibilidad (<code>semanticLabel</code>, tooltips)</li>
      <li>Caso "Configurable" con knobs en Widgetbook</li>
    </ul>
  </li>
  <li><strong>A3. Gestión de Eventos y Callbacks Personalizados</strong>
    <ul style="line-height: 1.6; margin-top: 4px;">
      <li>Evento <code>onChanged</code></li>
      <li>Definición de <code>enum StepperLimit</code> y <code>typedef LimitReached</code></li>
      <li>Evento <code>onLimitReached</code> y prevención de disparos espurios</li>
      <li>Integración visual con <code>SnackBar</code></li>
    </ul>
  </li>
  <li><strong>A4. Batería de Pruebas y Cobertura de Código</strong>
    <ul style="line-height: 1.6; margin-top: 4px;">
      <li>Función pura desacoplada <code>nextStepperValue</code> y pruebas unitarias</li>
      <li>Pruebas de widget (interacciones, estados y aserciones)</li>
      <li>Prueba Golden de fidelidad visual (valor 5)</li>
      <li>Informe y captura de cobertura LCOV (100.0%)</li>
    </ul>
  </li>
  <li><strong>A5. Documentación y Control Estático de Calidad</strong>
    <ul style="line-height: 1.6; margin-top: 4px;">
      <li>Documentación con dartdoc (<code>///</code>) y ejemplos</li>
      <li>Activación de la regla estricta <code>public_member_api_docs</code></li>
      <li>Generación de documentación HTML con <code>dart doc</code></li>
      <li>Actualización del <code>README.md</code></li>
    </ul>
  </li>
  <li><strong>A6. Empaquetado y Publicación</strong>
    <ul style="line-height: 1.6; margin-top: 4px;">
      <li>Versionado semántico <code>1.1.0</code> y registro en <code>CHANGELOG.md</code></li>
      <li>Gestión de releases en Git y etiqueta <code>v1.1.0</code></li>
      <li>Análisis detallado de <code>dart pub publish --dry-run</code></li>
    </ul>
  </li>
  <li><strong>A7. Aplicación Internacionalizada (stepper_demo)</strong>
    <ul style="line-height: 1.6; margin-top: 4px;">
      <li>Configuración de localización en español e inglés</li>
      <li>Pantalla de compra de entradas con <code>QuantityStepper</code> y <code>StarRating</code></li>
      <li>Plurales ICU, formateo de moneda y fechas localizadas</li>
      <li>Evidencias y capturas en ambos idiomas</li>
    </ul>
  </li>
</ol>

<!-- SECCIÓN A1 -->
<div class="page-break"></div>
<h1>A1. Primer Componente y Catálogo</h1>

<p>
  En esta primera fase se ha diseñado e implementado el componente <code>QuantityStepper</code> en el paquete Flutter <code>ui_kit_dam</code> (ubicado en <code>lib/src/quantity_stepper.dart</code>). El widget proporciona un control intuitivo y estandarizado para la selección de valores numéricos discretos.
</p>

<h2>1.1 y 1.2 Implementación Inicial</h2>
<p>
  El componente organiza visualmente en una fila horizontal (<code>Row</code>) un botón para decrementar con icono <code>Icons.remove</code>, un área central que muestra el valor numérico actual formateado y estilizado con la tipografía del tema, y un botón para incrementar con icono <code>Icons.add</code>.
</p>
<p>
  Al pulsar el botón de adición el valor se incrementa en una unidad, y al pulsar el de sustracción se decrementa en una unidad, invocando internamente <code>setState()</code> para provocar el redibujado reactivo del widget.
</p>

<h2>1.3 Exportación en la Biblioteca</h2>
<p>
  Para mantener una arquitectura modular limpia con aislamiento del directorio <code>src/</code>, el componente se exporta directamente desde el archivo de barrera principal <code>lib/ui_kit_dam.dart</code>:
</p>
<pre><code>library;

export 'src/info_badge.dart';
export 'src/quantity_stepper.dart';
export 'src/star_rating.dart';</code></pre>

<h2>1.4 Integración en Widgetbook ("Por defecto")</h2>
<p>
  Se ha configurado el catálogo de componentes Widgetbook en el archivo <code>widgetbook/widgetbook.dart</code>, permitiendo previsualizar el caso de uso <strong>"Por defecto"</strong> en un entorno aislado donde se instancia <code>QuantityStepper()</code> con sus valores iniciales predeterminados (rango 0 a 10, valor 0).
</p>

<div class="callout callout-info">
  <div class="callout-title">Pregunta A1.5 de la Tarea: ¿Por qué este componente es un StatefulWidget e InfoBadge no?</div>
  <p>
    En el modelo de renderizado reactivo de Flutter, la elección entre un <code>StatefulWidget</code> y un <code>StatelessWidget</code> responde a la necesidad de gestionar o no un <strong>estado mutable a lo largo del tiempo</strong>:
  </p>
  <ul style="margin-bottom: 0;">
    <li>
      <strong><code>QuantityStepper</code> es un <code>StatefulWidget</code></strong> porque mantiene un ciclo de vida con datos internos dinámicos (la variable privada <code>_value</code>) que mutan directamente como resultado de la interacción del usuario (pulsación de los botones <code>+</code> y <code>−</code>). El widget delega su lógica en un objeto asociado de tipo <code>State&lt;QuantityStepper&gt;</code>, el cual invoca <code>setState()</code> para encolar la reconstrucción del subárbol de widgets mostrando el nuevo número sin requerir que un widget ancestro le reinyecte dicho valor.
    </li>
    <li>
      <strong><code>InfoBadge</code> es un <code>StatelessWidget</code></strong> porque es un componente <em>puramente presentacional e inmutable</em>. Su función es exclusivamente proyectar en pantalla la información que recibe desde su constructor (como el texto de la etiqueta <code>label</code>, el <code>color</code> y el icono opcional <code>icon</code>). Dado que la insignia no almacena datos que varíen por iniciativa propia tras su instanciación, cualquier actualización visual futura se produce cuando su widget padre reconstruye la interfaz con nuevas propiedades, haciendo innecesaria la sobrecarga de un objeto <code>State</code> separado.
    </li>
  </ul>
</div>

<!-- SECCIÓN A2 -->
<div class="page-break"></div>
<h1>A2. Propiedades, Valores por Defecto y Accesibilidad</h1>

<h2>2.1 y 2.2 Propiedades y Validaciones por Aserción</h2>
<p>
  Para otorgar versatilidad al selector, se han añadido propiedades configurables con valores por defecto bien definidos:
</p>
<table class="data-table">
  <thead>
    <tr>
      <th>Propiedad</th>
      <th>Tipo</th>
      <th>Por Defecto</th>
      <th>Validación mediante assert</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>min</code></td>
      <td><code>int</code></td>
      <td><code>0</code></td>
      <td><code>assert(min &lt; max, 'min debe ser menor que max')</code></td>
    </tr>
    <tr>
      <td><code>max</code></td>
      <td><code>int</code></td>
      <td><code>10</code></td>
      <td><code>assert(min &lt; max, 'min debe ser menor que max')</code></td>
    </tr>
    <tr>
      <td><code>step</code></td>
      <td><code>int</code></td>
      <td><code>1</code></td>
      <td><code>assert(step &gt; 0, 'step debe ser mayor que 0')</code></td>
    </tr>
    <tr>
      <td><code>initialValue</code></td>
      <td><code>int</code></td>
      <td>igual a <code>min</code></td>
      <td><code>assert(initialValue &gt;= min &amp;&amp; initialValue &lt;= max)</code></td>
    </tr>
  </tbody>
</table>

<h2>2.3 Seguridad en Entornos de Producción (Release)</h2>
<p>
  Puesto que los <code>assert</code> de Dart son descartados durante la compilación en modo <em>release</em> (<code>--release</code>), el componente implementa un mecanismo de clamping en tiempo de ejecución:
</p>
<pre><code>// Protección activa incluso si se desactivan las aserciones:
_value = _value.clamp(widget.min, widget.max);</code></pre>
<p>
  Asimismo, en el método <code>didUpdateWidget</code> se detecta si las cotas <code>min</code> o <code>max</code> cambian dinámicamente desde el widget padre, reajustando de inmediato el valor interno dentro de los nuevos márgenes.
</p>

<h2>2.4 Desactivación Reactiva de Botones</h2>
<p>
  Siguiendo las directrices de diseño de Material Design, los botones se deshabilitan explícitamente cuando no existe posibilidad de continuar la operación, asignando <code>null</code> a su propiedad <code>onPressed</code>:
</p>
<pre><code>final bool canDecrement = _value &gt; widget.min;
final bool canIncrement = _value &lt; widget.max;

IconButton(
  icon: const Icon(Icons.remove),
  onPressed: canDecrement ? () =&gt; _applyDelta(-widget.step) : null,
)
IconButton(
  icon: const Icon(Icons.add),
  onPressed: canIncrement ? () =&gt; _applyDelta(widget.step) : null,
)</code></pre>

<h2>2.5 Accesibilidad Semántica y Tooltips</h2>
<p>
  El widget implementa tres propiedades textuales para permitir su internacionalización y asistencia tecnológica mediante lectores de pantalla (TalkBack / VoiceOver):
</p>
<ul>
  <li><code>semanticLabel</code> (por defecto <code>'Cantidad'</code>): Configurado en el widget <code>Semantics</code> que envuelve el contenedor.</li>
  <li><code>decrementTooltip</code> (por defecto <code>'Restar'</code>): Asignado a la propiedad <code>tooltip</code> del botón de sustracción.</li>
  <li><code>incrementTooltip</code> (por defecto <code>'Sumar'</code>): Asignado a la propiedad <code>tooltip</code> del botón de adición.</li>
</ul>

<h2>2.6 Caso "Configurable" en Widgetbook</h2>
<p>
  En <code>widgetbook/widgetbook.dart</code> se implementó el caso dinámico donde el diseñador puede manipular los parámetros <code>min</code>, <code>max</code> y <code>step</code> en tiempo real mediante los controles (knobs) interactivos del catálogo.
</p>

<div class="screenshot-container">
  <img class="screenshot-img" src="{img_widgetbook}" style="max-height: 200px;" alt="Catálogo Widgetbook">
  <div class="screenshot-caption">Figura 1: Previsualización de los casos "Por defecto" y "Configurable" en el catálogo de componentes.</div>
</div>

<!-- SECCIÓN A3 -->
<div class="page-break"></div>
<h1>A3. Eventos Propios y Manejo de Límites</h1>

<h2>3.1 Emisión de Cambios con <code>onChanged</code></h2>
<p>
  Se ha provisto la propiedad <code>final ValueChanged&lt;int&gt;? onChanged;</code>. Cuando el usuario pulsa un botón y la operación modifica el valor numérico, se notifica inmediatamente a la función callback suministrada con el nuevo entero.
</p>

<h2>3.2 y 3.3 Definición de Tipos y Evento <code>onLimitReached</code></h2>
<p>
  Se formalizó la estructura para la notificación de llegada a extremos mediante un tipo enumerado y un alias de función (typedef):
</p>
<pre><code>/// Límites alcanzables por [QuantityStepper].
enum StepperLimit {{ min, max }}

/// Firma del callback para la notificación de límites.
typedef LimitReached = void Function(StepperLimit limit);</code></pre>
<p>
  El widget expone la propiedad <code>final LimitReached? onLimitReached;</code>. Cuando el valor alcanza la cota superior <code>widget.max</code>, se invoca <code>onLimitReached?.call(StepperLimit.max)</code>. Si alcanza la cota inferior <code>widget.min</code>, se invoca <code>onLimitReached?.call(StepperLimit.min)</code>.
</p>

<h2>3.4 Ausencia de Eventos si el Valor no Cambia</h2>
<p>
  Para salvaguardar el rendimiento y evitar eventos duplicados o redundantes, la función interna <code>_applyDelta</code> realiza una comparación previa:
</p>
<pre><code>final nextValue = nextStepperValue(
  current: _value,
  delta: delta,
  min: widget.min,
  max: widget.max,
);

if (nextValue == _value) {{
  return; // No se muta el estado ni se emite ningún callback
}}</code></pre>

<h2>3.5 Pantalla de Prueba con SnackBar</h2>
<p>
  Al alcanzar el tope máximo, se diseñó la notificación mediante un <code>SnackBar</code> flotante con el mensaje <strong>"Has llegado al máximo"</strong>, probado tanto en las pruebas automáticas como en la aplicación final.
</p>

<div class="screenshot-container">
  <img class="screenshot-img" src="{img_app_limit}" style="max-height: 380px;" alt="SnackBar Límite Máximo">
  <div class="screenshot-caption">Figura 2: Notificación interactiva con SnackBar al alcanzar el límite superior (8 entradas).</div>
</div>

<!-- SECCIÓN A4 -->
<div class="page-break"></div>
<h1>A4. Pruebas Unitarias, de Widget, Golden y Cobertura</h1>

<h2>4.1 Función Pura <code>nextStepperValue</code></h2>
<p>
  Para favorecer una arquitectura desacoplada y comprobar el cálculo de valores de forma determinista y sin efectos secundarios, el algoritmo de cómputo se extrajo como una función pura independiente:
</p>
<pre><code>int nextStepperValue({{
  required int current,
  required int delta,
  required int min,
  required int max,
}}) {{
  final next = current + delta;
  if (next &lt; min) return min;
  if (next &gt; max) return max;
  return next;
}}</code></pre>
<p>
  Se redactaron 6 pruebas unitarias específicas que cubren: incremento ordinario, decremento ordinario, tope en límite superior, salto con step mayor que el margen hasta max, tope en límite inferior y salto negativo acotado a min.
</p>

<h2>4.2 Pruebas de Widget</h2>
<p>
  En <code>test/quantity_stepper_test.dart</code> se implementaron pruebas de integración de interfaz con <code>WidgetTester</code> verificando:
</p>
<ol>
  <li>Que pulsar el botón <code>+</code> renderiza el nuevo valor e invoca <code>onChanged</code> con el entero correcto.</li>
  <li>Que el botón <code>−</code> está desactivado (<code>onPressed == null</code>) cuando el valor está en el mínimo.</li>
  <li>Que <code>onLimitReached</code> recibe <code>StepperLimit.max</code> al alcanzar el valor máximo.</li>
  <li>Que el <code>SnackBar</code> con el texto "Has llegado al máximo" se muestra en pantalla.</li>
  <li>Que <code>didUpdateWidget</code> reajusta el valor si las cotas cambian externamente.</li>
</ol>

<h2>4.3 Prueba Golden de Fidelidad Visual</h2>
<p>
  Se generó una prueba golden de píxel exacto validando el aspecto del componente con valor 5 (fichero <code>test/goldens/quantity_stepper_val5.png</code>):
</p>
<div class="screenshot-container">
  <img class="screenshot-img" src="{img_golden}" style="max-height: 120px; padding: 10px; background: #fff;" alt="Golden test val 5">
  <div class="screenshot-caption">Figura 3: Captura Golden generada de QuantityStepper con valor 5.</div>
</div>

<h2>4.4 Cobertura de Código (100.0%)</h2>
<p>
  Tras ejecutar <code>flutter test --coverage</code>, el análisis del archivo LCOV confirmó una cobertura total de líneas ejecutables del <strong>100.0%</strong> (55 de 55 líneas) en <code>quantity_stepper.dart</code>:
</p>

<div class="screenshot-container">
  <img class="screenshot-img" src="{img_coverage}" style="max-height: 320px;" alt="Informe de Cobertura LCOV">
  <div class="screenshot-caption">Figura 4: Informe de cobertura generado mediante análisis de LCOV (100.0% en QuantityStepper).</div>
</div>

<!-- SECCIÓN A5 -->
<div class="page-break"></div>
<h1>A5. Documentación y Control Estático de Calidad</h1>

<h2>5.1 Documentación con Dartdoc (<code>///</code>)</h2>
<p>
  Todos los elementos públicos del paquete (clases, constructores, atributos, métodos, enum y typedef) han sido rigurosamente documentados en formato Markdown mediante triples barras (<code>///</code>), incluyendo parámetros detallados y bloques de código de ejemplo para facilitar la experiencia de integración de otros desarrolladores.
</p>

<h2>5.2 Regla <code>public_member_api_docs</code> y Análisis Estático</h2>
<p>
  Se incorporó la regla al archivo <code>analysis_options.yaml</code>:
</p>
<pre><code>include: package:flutter_lints/flutter.yaml

linter:
  rules:
    - public_member_api_docs</code></pre>
<p>
  Al ejecutar <code>flutter analyze</code>, el analizador estático certifica que el código cumple estrictamente todos los estándares sin advertencias ni errores: <strong>No issues found!</strong>.
</p>

<h2>5.3 Generación de Documentación HTML con <code>dart doc</code></h2>
<p>
  Se ejecutó la herramienta oficial <code>dart doc</code>, procesando las librerías públicas y generando el sitio web de documentación en <code>doc/api/</code> sin una sola advertencia (<em>Found 0 warnings and 0 errors</em>).
</p>

<div class="screenshot-container">
  <img class="screenshot-img" src="{img_dartdoc}" style="max-height: 400px;" alt="Página de QuantityStepper generada por dart doc">
  <div class="screenshot-caption">Figura 5: Documentación generada con dart doc para la clase QuantityStepper.</div>
</div>

<h2>5.4 Actualización de <code>README.md</code></h2>
<p>
  Se actualizó detalladamente el <code>README.md</code> del paquete con la descripción conceptual, tabla completa de propiedades, consideraciones de seguridad, ejemplos de código e instrucciones para su importación mediante Git.
</p>

<!-- SECCIÓN A6 -->
<div class="page-break"></div>
<h1>A6. Empaquetado y Publicación</h1>

<h2>6.1 y 6.2 Versionado y Publicación en Git</h2>
<p>
  Se elevó la versión del paquete a <code>1.1.0</code> en <code>pubspec.yaml</code>, y se documentaron detalladamente todas las novedades en <code>CHANGELOG.md</code>. Seguidamente, se realizó el commit en el repositorio local y se creó la etiqueta anotada <strong><code>v1.1.0</code></strong>:
</p>
<pre><code>$ git tag -a v1.1.0 -m "Release v1.1.0 - QuantityStepper, StarRating, InfoBadge"
$ git push origin main
$ git push origin v1.1.0</code></pre>

<h2>6.3 Dependencia por Git con Etiqueta Fijada</h2>
<p>
  En la nueva aplicación <code>stepper_demo</code>, se configuró la dependencia en <code>pubspec.yaml</code> vinculada directamente al repositorio remoto y bloqueada en la etiqueta <code>v1.1.0</code>:
</p>
<pre><code>dependencies:
  ui_kit_dam:
    git:
      url: git@github.com:antcanor/Diseno-de-Interfaces.git
      ref: v1.1.0
      path: ui_kit_dam</code></pre>
<p>
  La resolución mediante <code>flutter pub get</code> confirmó la descarga exitosa del commit etiquetado <code>caee87b / 2839fcd</code> en la caché de paquetes de Flutter.
</p>

<h2>6.4 Análisis de <code>dart pub publish --dry-run</code></h2>
<p>
  Al ejecutar el comando de validación para empaquetado:
</p>
<pre><code>$ dart pub publish --dry-run
Resolving dependencies...
Publishing ui_kit_dam 1.1.0 to https://pub.dev:
Total compressed archive size: 10 KB.
Validating package...
Package has 0 warnings.</code></pre>

<div class="callout callout-success">
  <div class="callout-title">Evaluación Técnica de Avisos en pub publish</div>
  <p>
    El paquete <code>ui_kit_dam</code> obtuvo la calificación óptima: <strong>Package has 0 warnings</strong>.
  </p>
  <p>
    <strong>Incidencia técnica identificada y analizada:</strong> Durante la ejecución inicial en el entorno local, se observó que la herramienta <code>pub</code> del SDK de Dart (fichero <code>package:pub/src/io.dart createTarGz</code>) presenta un fallo conocido de codificación de rutas cuando el directorio padre contiene caracteres de espacio en blanco (transformando <code>actividad 2 tema 3</code> en <code>actividad%202%20tema%203</code> y generando un error de discrepancia de rutas relativas). Para garantizar la máxima interoperabilidad y robustez tanto en sistemas de integración continua como en proyectos dependientes, se estructuró la raíz del paquete de manera canónica sin espacios, logrando una validación impecable con 0 avisos.
  </p>
</div>

<!-- SECCIÓN A7 -->
<div class="page-break"></div>
<h1>A7. Aplicación Internacionalizada (stepper_demo)</h1>

<h2>7.1 Configuración de Localización (i18n)</h2>
<p>
  Se configuró el generador de internacionalización de Flutter mediante <code>l10n.yaml</code>, utilizando como plantilla base el idioma español (<code>lib/l10n/app_es.arb</code>) y añadiendo la variante en lengua inglesa (<code>lib/l10n/app_en.arb</code>).
</p>

<h2>7.2 Pantalla de Compra de Entradas</h2>
<p>
  Se diseñó una pantalla moderna de compra para el <em>"Gran Concierto Sinfónico de Primavera"</em> en el Auditorio Víctor Villegas, que combina:
</p>
<ul>
  <li>Un <code>QuantityStepper</code> con rango acotado entre <strong>1 y 8 entradas</strong>.</li>
  <li>Un componente interactivo <code>StarRating</code> para valorar el evento de 1 a 5 estrellas.</li>
  <li>Insignias informativas <code>InfoBadge</code> para categorización visual.</li>
</ul>

<h2>7.3 Formateo Avanzado: Plurales ICU, Monedas y Fechas</h2>
<p>
  La interfaz maneja reglas de formateo dinámico basadas en la configuración regional (Locale):
</p>
<table class="data-table">
  <thead>
    <tr>
      <th>Elemento</th>
      <th>Formato Español (es)</th>
      <th>Formato Inglés (en)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Plural ICU</strong></td>
      <td><code>1 entrada</code> / <code>3 entradas</code></td>
      <td><code>1 ticket</code> / <code>3 tickets</code></td>
    </tr>
    <tr>
      <td><strong>Moneda</strong></td>
      <td><code>4,50 €</code> (coma decimal, símbolo al final)</td>
      <td><code>€4.50</code> (punto decimal, símbolo al inicio)</td>
    </tr>
    <tr>
      <td><strong>Fecha de evento</strong></td>
      <td><code>sábado, 24 de octubre de 2026</code></td>
      <td><code>Saturday, October 24, 2026</code></td>
    </tr>
    <tr>
      <td><strong>Tooltips y Semántica</strong></td>
      <td><code>"Restar entrada"</code> / <code>"Sumar entrada"</code></td>
      <td><code>"Remove ticket"</code> / <code>"Add ticket"</code></td>
    </tr>
  </tbody>
</table>

<h2>7.4 y 7.5 Evidencias Visuales en Ambos Idiomas</h2>
<p>
  La aplicación incluye un selector interactivo en la barra superior (<code>SegmentedButton</code>) que permite alternar instantáneamente entre español e inglés, respetando asimismo el idioma por defecto del dispositivo:
</p>

<div class="grid-2">
  <div class="screenshot-container">
    <img class="screenshot-img" src="{img_app_es}" alt="Aplicación en Español">
    <div class="screenshot-caption">Figura 6: Interfaz en Español (3 entradas, 13,50 €).</div>
  </div>
  <div class="screenshot-container">
    <img class="screenshot-img" src="{img_app_en}" alt="Aplicación en Inglés">
    <div class="screenshot-caption">Figura 7: Interfaz en Inglés (5 tickets, €22.50, 5 estrellas).</div>
  </div>
</div>

<div class="footer-note">
  Memoria elaborada por <strong>Antonio Cano Ruiz</strong> para la asignatura de Diseño de Interfaces - 2º DAM &bull; Curso 2026/2027
</div>

</body>
</html>
"""

output_html = '/home/antonio/Documentos/DAM/Diseno-de-Interfaces/actividad 2 tema 3/memoria.html'
with open(output_html, 'w', encoding='utf-8') as f:
    f.write(html_content)

print(f"HTML generado en {output_html}")

pdf_output = '/home/antonio/Documentos/DAM/Diseno-de-Interfaces/actividad 2 tema 3/Memoria_Actividad2_Tema3_Antonio_Cano_Ruiz.pdf'
pdf_output_root = '/home/antonio/Documentos/DAM/Diseno-de-Interfaces/Memoria_Actividad2_Tema3_Antonio_Cano_Ruiz.pdf'

chrome_cmd = [
    'google-chrome',
    '--headless',
    '--no-sandbox',
    '--disable-gpu',
    f'--print-to-pdf={pdf_output}',
    '--no-pdf-header-footer',
    f'file://{output_html}'
]

print("Compilando PDF con Google Chrome...")
res = subprocess.run(chrome_cmd, capture_output=True, text=True)
print(res.stdout)
if res.returncode == 0:
    print(f"PDF generado con éxito: {pdf_output}")
    # Copiamos también a la raíz para fácil acceso
    import shutil
    shutil.copyfile(pdf_output, pdf_output_root)
    print(f"PDF copiado a la raíz: {pdf_output_root}")
else:
    print(f"Error generando PDF: {res.stderr}")
