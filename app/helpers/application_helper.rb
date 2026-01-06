module ApplicationHelper
	def sort_link(label, column)
	  dir = (params[:sort] == column && params[:dir] == "asc") ? "desc" : "asc"
	  arrow = params[:sort] == column ? (dir == "asc" ? "↑" : "↓") : ""

	  link_to "#{label} #{arrow}".html_safe,
	          params.permit(:q, :page).merge(sort: column, dir: dir),
	          class: "sort-link"
	end
end
