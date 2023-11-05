if FORMAT:match 'latex' then
  title = ""

  function Para(el)
    if (el.c[1].t == "Span" and el.c[1].classes[1] == "title") then
      -- get mycode block's title, and put in global variable
      title = pandoc.utils.stringify(el.c[1])
      return ""
    end
  end

  function Span(el)
    beg_v = ""
    end_v = ""
    if el.classes[1] == "part" then
      beg_v = "\\part{"
      end_v = "}"
    elseif el.classes[1] == "inlineconsole" then
      beg_v = "\\inlineconsole{"
      end_v = "}"
    elseif el.classes[1] == "commandbox" then
      beg_v = "\\commandbox{"
      end_v = "}"
    elseif el.classes[1] == "configfile" then
      beg_v = "\\configfile{"
      end_v = "}"
    elseif el.classes[1] == "configdir" then
      beg_v = "\\configdir{"
      end_v = "}"
    elseif el.classes[1] == "configlink" then
      beg_v = "\\configlink{"
      end_v = "}"
    elseif el.classes[1] == "movie" then
      beg_v = "\\movie{"
      end_v = "}"
    end

    table.insert(el.content, 1, pandoc.RawInline("latex", beg_v))
    table.insert(el.content, pandoc.RawInline("latex", end_v))
    return el
  end

  function Div(el)
    beg_v = ""
    end_v = ""
    if el.classes[1] == "infobox" then
      beg_v = "\\begin{infobox}"
      end_v = "\\end{infobox}"
    elseif el.classes[1] == "warnbox" then
      beg_v = "\\begin{warnbox}"
      end_v = "\\end{warnbox}"
    elseif el.classes[1] == "errorbox" then
      beg_v = "\\begin{errorbox}"
      end_v = "\\end{errorbox}"
    elseif el.classes[1] == "questionbox" then
      beg_v = "\\begin{questionbox}"
      end_v = "\\end{questionbox}"
    elseif el.classes[1] == "exercisebox" then
      beg_v = "\\begin{exercisebox}"
      end_v = "\\end{exercisebox}"
    elseif el.classes[1] == "mycode" then
      -- get mycode block's title
      beg_v = "\\begin{mycode}{"..title.."}"
      title = ""
      end_v = "\\end{mycode}"
    end

    table.insert(el.content, 1, pandoc.RawInline("latex", beg_v))
    table.insert(el.content, pandoc.RawInline("latex", end_v))
    return el
  end

end

