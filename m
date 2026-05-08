Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35F43D47DE
	for <netfs@lists.linux.dev>; Fri,  8 May 2026 18:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778264773; cv=none; b=m5Lcd1JIdYmXLEyncUY4+t9i92mkezhCJQW53duwRhQWxVDLXlXmMJ/HGC4SE/zxWLnalbPMQ9KOBZ9RX0JQBIqvmqqZ1dqyI/0et33L0r6t+sCx777r+aTAafnqlwzYffpKM9QtmeRZjjOPwDw9InWdqcLjk+/exhTRdCvdE0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778264773; c=relaxed/simple;
	bh=gPt2p5mRydIx09aB5eoi5h+EjR87ILB07pmtiyqKD6c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqfNXhtwHfPQoj8RCQszeEdYkuIEfEMcivYhR7u391l1zt9V0YRxXW86lIa/h2GM+TQZjpKULWlWwuTX85hdYVIWO0yQ/Bc/8lfBEZK0bGN8GbGaMwgOaEB+Z8uCCmpjHiJE9jtlFm9lGn22310fpLuhziUkfqoCUNYQWcAri60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDacNlXs; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDacNlXs"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45562c41ec7so165646f8f.1
        for <netfs@lists.linux.dev>; Fri, 08 May 2026 11:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778264770; x=1778869570; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nadJ4F3fO0o2IbMhIzDipftu6czfRb7SQ9fGD7WtGtQ=;
        b=aDacNlXs4QwNSnrFhYBknhe5X3ZNuTEi/adJel56gS73CAmFYWl9vnKxVsvYyzVRHR
         8+o+TI9dHBkDZY57p87lgtLztBiw1Orvt8W4C3iKgb3bVzxii+/UWXPRIymnuzzfEhyk
         AdpuVCsdaWFgT4Iyz8qWTryiFFKVln/CqYWlffFi6gfqWSu4njJNXAfObUVNQecO1EF5
         QK5qGuJrSOsasIs1zCSDWi8MXQOworcBl30cLaOZ9Hn81utkd/GTGgu3o5Op+qBVNte6
         QH0AUHTMftxs2zQQ0BOBQhcwvZ7kUzh0wZJQ4K1I6iZ6TQ+TuXOkabTEmp624iyzhzOC
         AU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778264770; x=1778869570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nadJ4F3fO0o2IbMhIzDipftu6czfRb7SQ9fGD7WtGtQ=;
        b=Ilp1NDIt+dXr9I0i4U4xmiJu4CGJdnd2mJc2DCE9Sh6NptrXH3THjS4xsKO5+wJToB
         AvicfYiaYT7QeYYhYoXvsliYwTGgVpHiWc42K+mePsKJ0K5coVmsRNLT3ZPcakbZMz7u
         LzCkoFSNZxOQKB3rToKSR54oSVXbHyEa8AdCe0a80WUugJpKCpNTc5RbRx+LLeS6vLSN
         MbKsfCVy3AF5lpxmpmpzlHZP4ru6aHIY0SyronqIwC1HP8avYdGzhE0JcvhcEUe3dlDn
         4E5e+mKbPiwlXYhTupysyazGpZegEwUrQSUMHSLo3MGWYeu8rQjaAU/i7UnNRAPpWAMS
         vsIg==
X-Forwarded-Encrypted: i=1; AFNElJ9UcCr8R0UMbnQ7eiYtKSgA4d22Uu6wjMtXqVhNSHMiQMdkBGgbLjmeZ629jVfM9UvGXIgwTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7ZQbGzKEUDaQcioDKgxOo1CZDLEFsw4X0jszDTga0Ld6NKMN3
	pMKj+xOQEl8KPu4jZrXlk/484Tx1L0nq9/MHIgOI7AwOjPHYrnsQQv3s
X-Gm-Gg: Acq92OH4KTDxpZX4jGvppwDz8R4ibdp+ulS5YyQpXUnjJDHeW8C6/lzDmTqrjug1QWW
	O+M3th+QhM3nDLC+79tUjfkooeXpPrj5uOce5u7FtMw1Zq73ZZn1/qRWf71tjNTTSLqHGxKCyt8
	WDaGVlFt6EvnCzvvCZLi4vFmQnCxRDSpd6kflCDpAD2vorXzrthrwWXqoZbYjwLQjupYi/o6D0m
	wCv1N08K8p0xzw6PVXydA12AsWM9iFRDoqcioefSYvQp46RQovMt3e8KDC2+Aa5JEbSIofsU7yx
	MMgnFG9XkHfYSv7wxAauFoMCbmz3gCaRk2AZCCHNW7GOgycEQWffmz6aXNwbaa/DLz8lonSTeqZ
	hpo4FscyfLQsPuRlmFtxlzBU6PIgeR/5ssJheAfmUNDnKBONh7j3o6OLAvPuiIQuNuJW7gXQpYy
	O2g6fi4tEoF3/n8GSwSAfwUdyusAX9kHRmeYCgfZon1w6+pMOHBTRhk0jS8Vep125g
X-Received: by 2002:a05:6000:420c:b0:43d:7508:c9c9 with SMTP id ffacd0b85a97d-4515c5752d8mr22366137f8f.27.1778264770073;
        Fri, 08 May 2026 11:26:10 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6c79fsm6435208f8f.15.2026.05.08.11.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 11:26:09 -0700 (PDT)
Date: Fri, 8 May 2026 19:26:06 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Adrien Reynard <reynard.adrien.08@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj
 Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng
 <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, David Howells <dhowells@redhat.com>,
 Paulo Alcantara <pc@manguebit.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 "open list:READ-COPY UPDATE (RCU)" <rcu@vger.kernel.org>, "open
 list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:DRIVER CORE, KOBJECTS, DEBUGFS
 AND SYSFS" <driver-core@lists.linux.dev>, "open list:FILESYSTEMS [NETFS
 LIBRARY]" <netfs@lists.linux.dev>, "open list:FILESYSTEMS [NETFS LIBRARY]"
 <linux-fsdevel@vger.kernel.org>, "open list:TRACING"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] docs: fix repeated word 'that' across documentation
Message-ID: <20260508192606.2423f50e@pumpkin>
In-Reply-To: <1501caea-8cff-4968-aca6-e8d4b20e0e80@linuxfoundation.org>
References: <20260508163759.16231-1-reynard.adrien.08@gmail.com>
	<1501caea-8cff-4968-aca6-e8d4b20e0e80@linuxfoundation.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 May 2026 11:15:28 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 5/8/26 10:37, Adrien Reynard wrote:
> 
> Missing commit log in all your patches - I don't patch 1/5 in
> my Inbox.
> 
> > Signed-off-by: Adrien Reynard <reynard.adrien.08@gmail.com>
> > ---
> >   Documentation/RCU/rcu.rst                          | 2 +-
> >   Documentation/driver-api/driver-model/overview.rst | 2 +-
> >   Documentation/filesystems/netfs_library.rst        | 2 +-
> >   Documentation/trace/histogram-design.rst           | 2 +-
> >   Documentation/trace/histogram.rst                  | 2 +-
> >   5 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/RCU/rcu.rst b/Documentation/RCU/rcu.rst
> > index bf6617b330a7..320ad3292b75 100644
> > --- a/Documentation/RCU/rcu.rst
> > +++ b/Documentation/RCU/rcu.rst
> > @@ -32,7 +32,7 @@ Frequently Asked Questions
> >     Just as with spinlocks, RCU readers are not permitted to
> >     block, switch to user-mode execution, or enter the idle loop.
> >     Therefore, as soon as a CPU is seen passing through any of these
> > -  three states, we know that that CPU has exited any previous RCU
> > +  three states, we know that CPU has exited any previous RCU  
> 
> The original intent might have been to say, "that cpu", so adding
> the missing comma after the first "that" or change "that" to "the"
> would make sense.
...

I don't think adding a comma would be correct.
The clause splits as 'we know that' 'that CPU' and the repeated 'that'
is absolutely correct.
Maybe 'that CPU' could be replaced by 'it'; but it can be difficult to
work out what back references like 'it' refer to.

You can re-order it, as (say):
	Therefore we know that as soon as a CPU is seen passing through any of these
	three states it has exited any previous RCU read-side critical sections.

But just because some grammar book says you shouldn't have repeated words
doesn't mean there aren't exceptions.

The sign writer was doing a new sign for the 'Pig and Whistle'.
Unfortunately the gaps between Pig and and and and and Whistle
ended up visibly different.

-- David


