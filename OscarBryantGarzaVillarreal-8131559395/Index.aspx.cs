using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Net;


namespace OscarBryantGarzaVillarreal_8131559395
{
    public partial class Index : System.Web.UI.Page
    {
        public int i = 1;
        protected void Page_Load(object sender, EventArgs e)
        {
            btn1.Click += new EventHandler(this.reg);
        }

        
        void reg(Object sender, EventArgs e)
        {

            if (Page.IsValid)
            {
                object[] array1 = new object[10];
                Saves objeto = new Saves(TextBox1.Text, TextBox2.Text, TextBox3.Text);

                //Arreglo de objetos
                array1[i] = objeto;
                i++;

                //Impresion en consola de visual (Interpretacion con dump)
                var dum = ObjectDumper.Dump(objeto);
                System.Diagnostics.Debug.WriteLine(objeto.ToString());
                //Json serialize solo esta en .Net core

                //Prueba de impresion en navegador
                Page.Response.Write("<script>console.log('" + "hola mundo" + "')</script>");

                //Limpiar formulario
                TextBox1.Text = "";
                TextBox2.Text = "";
                TextBox3.Text = "";

            }        

        }

        void prueba()
        {
            
        }

        class Saves
        {
            public String rfc;
            public String razon;
            public String password;
            public Saves (String rfc, String razon, String password)
            {
                this.rfc = rfc;
                this.razon = razon;
                this.password = password;
            }
        }

        public class ObjectDumper
        {
            private int _level;
            private readonly int _indentSize;
            private readonly StringBuilder _stringBuilder;
            private readonly List<int> _hashListOfFoundElements;

            private ObjectDumper(int indentSize)
            {
                _indentSize = indentSize;
                _stringBuilder = new StringBuilder();
                _hashListOfFoundElements = new List<int>();
            }

            public static string Dump(object element)
            {
                return Dump(element, 2);
            }

            public static string Dump(object element, int indentSize)
            {
                var instance = new ObjectDumper(indentSize);
                return instance.DumpElement(element);
            }

            private string DumpElement(object element)
            {
                if (element == null || element is ValueType || element is string)
                {
                    Write(FormatValue(element));
                }
                else
                {
                    var objectType = element.GetType();
                    if (!typeof(IEnumerable).IsAssignableFrom(objectType))
                    {
                        Write("{{{0}}}", objectType.FullName);
                        _hashListOfFoundElements.Add(element.GetHashCode());
                        _level++;
                    }

                    var enumerableElement = element as IEnumerable;
                    if (enumerableElement != null)
                    {
                        foreach (object item in enumerableElement)
                        {
                            if (item is IEnumerable && !(item is string))
                            {
                                _level++;
                                DumpElement(item);
                                _level--;
                            }
                            else
                            {
                                if (!AlreadyTouched(item))
                                    DumpElement(item);
                                else
                                    Write("{{{0}}} <-- bidirectional reference found", item.GetType().FullName);
                            }
                        }
                    }
                    else
                    {
                        MemberInfo[] members = element.GetType().GetMembers(BindingFlags.Public | BindingFlags.Instance);
                        foreach (var memberInfo in members)
                        {
                            var fieldInfo = memberInfo as FieldInfo;
                            var propertyInfo = memberInfo as PropertyInfo;

                            if (fieldInfo == null && propertyInfo == null)
                                continue;

                            var type = fieldInfo != null ? fieldInfo.FieldType : propertyInfo.PropertyType;
                            object value = fieldInfo != null
                                               ? fieldInfo.GetValue(element)
                                               : propertyInfo.GetValue(element, null);

                            if (type.IsValueType || type == typeof(string))
                            {
                                Write("{0}: {1}", memberInfo.Name, FormatValue(value));
                            }
                            else
                            {
                                var isEnumerable = typeof(IEnumerable).IsAssignableFrom(type);
                                Write("{0}: {1}", memberInfo.Name, isEnumerable ? "..." : "{ }");

                                var alreadyTouched = !isEnumerable && AlreadyTouched(value);
                                _level++;
                                if (!alreadyTouched)
                                    DumpElement(value);
                                else
                                    Write("{{{0}}} <-- bidirectional reference found", value.GetType().FullName);
                                _level--;
                            }
                        }
                    }

                    if (!typeof(IEnumerable).IsAssignableFrom(objectType))
                    {
                        _level--;
                    }
                }

                return _stringBuilder.ToString();
            }

            private bool AlreadyTouched(object value)
            {
                if (value == null)
                    return false;

                var hash = value.GetHashCode();
                for (var i = 0; i < _hashListOfFoundElements.Count; i++)
                {
                    if (_hashListOfFoundElements[i] == hash)
                        return true;
                }
                return false;
            }

            private void Write(string value, params object[] args)
            {
                var space = new string(' ', _level * _indentSize);

                if (args != null)
                    value = string.Format(value, args);

                _stringBuilder.AppendLine(space + value);
            }

            private string FormatValue(object o)
            {
                if (o == null)
                    return ("null");

                if (o is DateTime)
                    return (((DateTime)o).ToShortDateString());

                if (o is string)
                    return string.Format("\"{0}\"", o);

                if (o is char && (char)o == '\0')
                    return string.Empty;

                if (o is ValueType)
                    return (o.ToString());

                if (o is IEnumerable)
                    return ("...");

                return ("{ }");
            }
        }



    }
}