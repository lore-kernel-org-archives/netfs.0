Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C8918DF8F
	for <netfs@lists.linux.dev>; Mon,  9 Sep 2024 23:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725926281; cv=none; b=toMobHVbq1G5HqP/u+wCVmnfuf1MVbR45ln6QO6knxBJM/6sVD8EHwFAJEK/XR7e+2asnduvn/VktL8HJ4hRIHqPl+yHv7LKVx0LprjVqmdSdTn16XhZBHy44UQxLrLl+VjF288rVRMIomon79/OtQHCt4HetKSHnanW5vpGNCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725926281; c=relaxed/simple;
	bh=lQhn2uPJQmP5XiJdjuiIobzcSaZmDikyUT/yUvUX32w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=es3+UUElls3eCf481ej+4vlDcmx3o/L3v4WTVEfP+8ct6TBCGVPzHbCsOcCVKMPkrkDsLImxLtbxpegiAeXw4QCzWTWdiQI/Asiv242M9GHJpYQcuc/IDTU918yC7gdk1oIEiMATj+CYwgDMjG0NgsDvUp5CpJ4s5HOjB/I4Es8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0+lIDdS; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0+lIDdS"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-49bc42bec6dso1341511137.0
        for <netfs@lists.linux.dev>; Mon, 09 Sep 2024 16:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725926277; x=1726531077; darn=lists.linux.dev;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lQhn2uPJQmP5XiJdjuiIobzcSaZmDikyUT/yUvUX32w=;
        b=T0+lIDdSlc6B+WwELzpCfnWYwbPjA8CVCiWvzIEYtu/o3Tgvsji/wt/rk0oF5OhkCR
         lFqnoqh7JM8cbz8LC8jxxz3OF1l8TfmX7MEBOnG0yAHY5X22ngAmcRoYSHDo5oJeMbKO
         4U/JD33rXc+4JFFPaNSMZorNTge6MJ5PyHmJcF/NVHEqtTvrdcg/QPXi1RLlDm0Qcn7r
         iqa9W4cE/8AkSak0xvdW0NhbZ/8xGvaWlivn+D7hRhxD2qCStLCIVB/r3z229h0lgvyq
         pu9HAfbjvoGv/PBqqSu+kwVbqcGYlOrXKIV+YJF9XRdQHWp0Vti7q8ewUvhW/QeDrcZA
         HI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725926277; x=1726531077;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lQhn2uPJQmP5XiJdjuiIobzcSaZmDikyUT/yUvUX32w=;
        b=PqGsjMyAxSMeMTgO7yG16i3erIwhtQaZejNZ01MoYxlWvp7Mf2Sdn1Sl5bI49Ch53P
         lTFr1weEwGGkSDagA6e6HD8h9IDO0qpGMESZfYZ33iuRUdQoT8aFXa/Of1szY8rTVJfY
         9HGHNw4v10RcIz2ELHC+Z3jw28Teclblnqupr0cJ+mtYuA7hz+pPFDO8LfXfBFn2w4WX
         KVf2f5LwBNPEknzPQjj26yAZJhEyk5gTdJtqBv2SxOr0qQ2AF35DflmyvoerXT5AymJ1
         F402a6DbxDcw3AMkRLzSsvl7Udk/a0NVUTL5W66JkOZEEISn5KKApjtx6B3igOBqivfS
         NtQA==
X-Gm-Message-State: AOJu0YxAG+RPPJHt8rLqI8xz/bXkuUMsDhzox24sED9poyrUdEVNSlBi
	w/1I1bPrDX7TCTopmtpehrGpldq/4joeHH/tks6+KyFiLE6PVT1r81x3lfMzWYikqzHkFOkNyRY
	7rjEBNdopC3zHxqUG4DRokuupc77NY0ug
X-Received: by 2002:a05:6102:2ac6:b0:492:9ca1:d35e with SMTP id
 ada2fe7eead31-49bde0f8b06mt9009670137.5.1725926277510; Mon, 09 Sep 2024
 16:57:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240908192307.20733-3-dennis.lamerice@gmail.com>
 <346199.1725873065@warthog.procyon.org.uk> <CAGZfcdkGw55MKTYxuOkCgu8kJU86jkERfLRJAP+J8Z6=0z1F+g@mail.gmail.com>
In-Reply-To: <CAGZfcdkGw55MKTYxuOkCgu8kJU86jkERfLRJAP+J8Z6=0z1F+g@mail.gmail.com>
From: Dennis Lam <dennis.lamerice@gmail.com>
Date: Mon, 9 Sep 2024 19:57:46 -0400
Message-ID: <CAGZfcdkCcjX0-xyR9UbhnnnnwZuRcKfah+FG+KkSNztj1EHKMw@mail.gmail.com>
Subject: Re: [PATCH] docs:filesystems: fix spelling and grammar mistakes on
 netfs library page
Cc: netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For those reading the mailing list, sorry for the top post. I'll be
more mindful in the future.

Dennis
