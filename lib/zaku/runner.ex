defmodule Zaku.Runner do
	def run(args) do
		System.no_halt(true)
		Zaku.start(:normal, args)
	end
end