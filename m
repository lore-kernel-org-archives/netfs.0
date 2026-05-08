Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9357F2FE056;
	Fri,  8 May 2026 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262776; cv=none; b=n8Uc4bEMefzvAcq8QWzGPxTBEhiaXgCsmRhscvDf8GAJW/WwaEANBslEBiOOKJN/wAAGsGQeDjqnpTbyid12ESdRWqXuLsCc+AGWVsBgsSWiyjwPvvi/a1w+qOeMndb+KWVQ9TlP8vy8kOyL9+SivG8gFDEiG23fGLizRS2YxFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262776; c=relaxed/simple;
	bh=7FO/OvjB81khbVySOVw1mhcX4mL/VhbRPd35cA9Jelc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8raS1IdjyzdMKlJzkNKkcQpCUuVQlhxY0crvAP9mT/IowDujSWTxbBOkfoPtD/8bzP4Pej45gNnv4tMV8LhZ89Y0r6ttuqC1XQ3RUSMop/wjXRM1GRyD34nRc7tWtrg1uym0WCL/AtY0HM9RMu2KsHj7kkVFvjgT5WWv3fWWsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bhp/xG+x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bhp/xG+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35495C2BCB0;
	Fri,  8 May 2026 17:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262776;
	bh=7FO/OvjB81khbVySOVw1mhcX4mL/VhbRPd35cA9Jelc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Bhp/xG+xadRrlmz/bfTShSKS7y2H/NrORoSuGsy2gx2sEAXSdSN2O6nEdoCn2+/oE
	 ai/3ujkjYhPSv6Q2VQ3yBLiXOYoMcD66gIbByk29qLaqxz5BGkPnxaV9weOix5FwAW
	 VJfBK8byNFeo5ZGNFdXKPeTL4u9GT+GV6lPj+IILe2o7Yc8mUatY6Ck1vCnM7Emhhh
	 oOuaH3u/OiIV2NtyEe0gNDu+RGmxZf2NTgueCVd12rb9wR2OibZY4Jp7YyQthlDfLy
	 Xf5ZFsbvYUIjRjeahDmaHky1CFECNsfxhm9hbYzmE0Yyq2qU60oIwJ29TFZ5x6+Z73
	 dY74NSOlqN5Dg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D2C3CCE06FB; Fri,  8 May 2026 10:52:55 -0700 (PDT)
Date: Fri, 8 May 2026 10:52:55 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Adrien Reynard <reynard.adrien.08@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"open list:READ-COPY UPDATE (RCU)" <rcu@vger.kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS" <driver-core@lists.linux.dev>,
	"open list:FILESYSTEMS [NETFS LIBRARY]" <netfs@lists.linux.dev>,
	"open list:FILESYSTEMS [NETFS LIBRARY]" <linux-fsdevel@vger.kernel.org>,
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] docs: fix repeated word 'that' across documentation
Message-ID: <6acba84c-c92c-4f64-ac26-3308620b2398@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260508163759.16231-1-reynard.adrien.08@gmail.com>
 <1501caea-8cff-4968-aca6-e8d4b20e0e80@linuxfoundation.org>
 <5f68ac30-21ac-494b-a140-2307e236f0a2@infradead.org>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f68ac30-21ac-494b-a140-2307e236f0a2@infradead.org>

On Fri, May 08, 2026 at 10:40:49AM -0700, Randy Dunlap wrote:
> 
> 
> On 5/8/26 10:15 AM, Shuah Khan wrote:
> > On 5/8/26 10:37, Adrien Reynard wrote:
> > 
> > Missing commit log in all your patches - I don't patch 1/5 in
> > my Inbox.
> > 
> >> Signed-off-by: Adrien Reynard <reynard.adrien.08@gmail.com>
> >> ---
> >>   Documentation/RCU/rcu.rst                          | 2 +-
> >>   Documentation/driver-api/driver-model/overview.rst | 2 +-
> >>   Documentation/filesystems/netfs_library.rst        | 2 +-
> >>   Documentation/trace/histogram-design.rst           | 2 +-
> >>   Documentation/trace/histogram.rst                  | 2 +-
> >>   5 files changed, 5 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/Documentation/RCU/rcu.rst b/Documentation/RCU/rcu.rst
> >> index bf6617b330a7..320ad3292b75 100644
> >> --- a/Documentation/RCU/rcu.rst
> >> +++ b/Documentation/RCU/rcu.rst
> >> @@ -32,7 +32,7 @@ Frequently Asked Questions
> >>     Just as with spinlocks, RCU readers are not permitted to
> >>     block, switch to user-mode execution, or enter the idle loop.
> >>     Therefore, as soon as a CPU is seen passing through any of these
> >> -  three states, we know that that CPU has exited any previous RCU
> >> +  three states, we know that CPU has exited any previous RCU
> > 
> > The original intent might have been to say, "that cpu", so adding
> > the missing comma after the first "that" or change "that" to "the"
> > would make sense.
> 
> Not a comma, please.
> I don't see a problem with "that that," but "that the" could also be OK.

This CPU was already mentioned.  So if for whatever reason we cannnot
stomach "that that", then "that this" would be better than "that the".

I suppose that false positives from simple grammar checkers might be
sufficient reason, but in this brave new world of LLMs, shouldn't we
be hoping for better?  ;-)

						Thanx, Paul

> >>     read-side critical sections.  So, if we remove an item from a
> >>     linked list, and then wait until all CPUs have switched context,
> >>     executed in user mode, or executed in the idle loop, we can
> 
> 
> -- 
> ~Randy
> 
