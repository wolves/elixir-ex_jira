defmodule ExJira.Project do
  alias ExJira.Request
  alias ExJira.QueryParams

  @moduledoc """
  Provides access to the Project resource.
  """

  @all_params [:expand, :recent]
  @get_params [:expand]

  @doc """
  Returns all projects. Request parameters as described [here](https://docs.atlassian.com/jira/REST/cloud/#api/2/project-getAllProjects)

  ## Examples

      iex> ExJira.Project.all()
      {:ok, [%{"id" => "1010"}, %{"id" => "1011"}]}

  """
  @spec all([{atom, String.t}]) :: Request.request_response
  def all(query_params \\ []) do
    Request.get_one("/project", QueryParams.convert(query_params, @all_params))
  end

  @doc """
  Same as `all/1` but raises error if it fails

  ## Examples

      iex> ExJira.Project.all!()
      [%{"id" => "1010"}, %{"id" => "1011"}]

  """
  @spec all!([{atom, String.t}]) :: [any]
  def all!(query_params \\ []) do
    case all(query_params) do
      {:ok, items} -> items
      {:error, reason} -> raise "Error in #{__MODULE__}.all!: #{inspect reason}"
    end
  end

  @doc """
  Returns the specified project as described [here](https://docs.atlassian.com/jira/REST/cloud/#api/2/project-getProject).

  ## Examples

      iex> ExJira.Project.get("1012")
      {:ok, %{"id" => "1012"}}

      iex> ExJira.Project.get("1012", expand: "lead,url,description")
      {:ok, %{"id" => "1012"}}

  """
  @spec get(String.t, [{atom, String.t}]) :: Request.request_response
  def get(id, query_params \\ []) do
    Request.get_one("/project/#{id}", QueryParams.convert(query_params, @get_params))
  end

  @doc """
  Same as `get/1` but raises error if it fails

  ## Examples

      iex> ExJira.Project.get!("1012")
      %{"id" => "1012"}

      iex> ExJira.Project.get!("1012", expand: "lead,url,description")
      %{"id" => "1012"}

  """
  @spec get!(String.t, [{atom, String.t}]) :: any
  def get!(id, query_params \\ []) do
    case get(id, query_params) do
      {:ok, item} -> item
      {:error, reason} -> raise "Error in #{__MODULE__}.get!: #{inspect reason}"
    end
  end

end