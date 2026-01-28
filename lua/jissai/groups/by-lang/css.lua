---@param hls jissai.highlights
---@param gr jissai.groups
return function(hls, gr)
    gr.cssTagName = hls.text
    gr.cssFunctionName = hls.function_.call
    gr.cssFunction = hls.function_.call
    gr.cssIdentifier = hls.text
    gr.cssClassName = hls.text
    gr.cssClassNameDot = hls.syntax.decoration
    gr.cssVendor = hls.text

    gr.cssCustomProp = hls.variable.define
    gr.StorageClass = hls.text

    gr.cssAtRule = hls.syntax.keyword
    gr.cssAtKeyword = hls.syntax.keyword

    gr.cssAttrRegion = hls.builtin.value
    gr.cssFontAttr = hls.builtin.keyword
    gr.cssPositioningAttr = hls.builtin.keyword
    gr.cssTransitionAttr = hls.builtin.keyword
    gr.cssCommonAttr = hls.builtin.keyword
    gr.cssColor = hls.builtin.value

    gr.cssNoise = hls.syntax.decoration
    gr.cssBraces = hls.syntax.decoration
    gr.cssAttrComma = hls.syntax.decoration
    gr.cssFunctionComma = hls.syntax.decoration
end
